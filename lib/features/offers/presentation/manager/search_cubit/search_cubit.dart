/// SearchCubit — search offers and count sponsorship views via use cases.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/constants/profession_keywords.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/offers/domain/use_cases/count_offer_view_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/offer_entity.dart';
import '../../../domain/use_cases/search_offers_use_case.dart';
import 'search_state.dart';

List<OfferEntity> _sortSponsoredWithShuffle(List<OfferEntity> list) {
  final sponsored = list
      .where((e) => e.sp == true || e.isViewSponsored == true)
      .toList();

  final normal = list
      .where((e) => !(e.sp == true || e.isViewSponsored == true))
      .toList();

  /// 🔥 shuffle الإعلانات فقط
  sponsored.shuffle();

  /// ترتيب العادي حسب rating
  normal.sort((a, b) => b.averageRating.compareTo(a.averageRating));

  return [...sponsored, ...normal];
}

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchOffersUseCase searchOffersUseCase;
  final CountOfferViewUseCase countOfferViewUseCase;
  final AppSessionCubit appSessionCubit;

  String _getUserHistoryKey() {
    final userId = appSessionCubit.currentUser?.uid ?? 'guest';
    return "search_history_$userId";
  }

  /// منع العد المتكرر لنفس الإعلان
  final Set<String> _countedOffersInThisSearch = {};

  SearchCubit(
    this.searchOffersUseCase,
    this.countOfferViewUseCase,
    this.appSessionCubit,
  ) : super(const SearchState());

  /// ===============================
  /// SEARCH
  /// ===============================
  List<OfferEntity> _sortSponsoredFirst(List<OfferEntity> list) {
    list.sort((a, b) {
      final aSponsored = a.sp == true || a.isViewSponsored == true;
      final bSponsored = b.sp == true || b.isViewSponsored == true;

      if (aSponsored && !bSponsored) return -1;
      if (!aSponsored && bSponsored) return 1;

      return b.averageRating.compareTo(a.averageRating);
    });

    return list;
  }

  Future<void> search(String query) async {
    final cleanedQuery = normalizeArabic(query.toLowerCase());

    if (cleanedQuery.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoading: true, query: cleanedQuery, error: null));

    try {
      await saveSearchHistory(cleanedQuery);

      final result = await searchOffersUseCase(cleanedQuery);

      /// =========================
      /// DEBUG
      /// =========================

      for (final offer in result) {
        final text = normalizeArabic(
          "${offer.title} "
                  "${offer.profession} "
                  "${offer.description} "
                  "${offer.location}"
              .toLowerCase(),
        );

        print("==================================");

        print("🔍 Searching for: $cleanedQuery");

        print("📌 Offer: ${offer.title}");

        print("📝 Full Text: $text");
      }

      /// =========================
      /// FILTER
      /// =========================

      final filtered = result.where((offer) {
        final text = normalizeArabic(
          "${offer.title} "
                  "${offer.profession} "
                  "${offer.description} "
                  "${offer.location}"
              .toLowerCase(),
        );

        final queryWords = normalizeArabic(
          cleanedQuery.toLowerCase(),
        ).split(" ").where((e) => e.trim().isNotEmpty).toList();

        /// الكلمات اللي ملهاش قيمة
        const ignoredWords = ["في", "ب", "من", "الى", "على", "عن", "مع"];

        final importantWords = queryWords
            .where((word) => !ignoredWords.contains(word))
            .toList();

        int score = 0;

        final normalizedText = text.replaceAll("ة", "ه").replaceAll("ى", "ي");

        for (final word in importantWords) {
          final normalizedWord = normalizeArabic(
            word,
          ).replaceAll("ة", "ه").replaceAll("ى", "ي");

          if (normalizedText.contains(normalizedWord)) {
            score++;
          }
        }

        /// لازم يطابق كلمة واحدة على الأقل
        return score > 0;
      }).toList();

      /// =========================
      /// Sponsored ترتيب
      /// =========================

      final finalList = _sortSponsoredWithShuffle(filtered);

      /// =========================
      /// Count Views
      /// =========================

      for (final offer in finalList) {
        await countOfferViewUseCase(
          offerId: offer.id,
          offerOwnerId: offer.userId,
          userId: appSessionCubit.currentUser?.uid,
        );
      }

      final history = await getSearchHistory();

      emit(
        state.copyWith(
          isLoading: false,

          results: finalList,

          originalResults: finalList,

          searchHistory: history,

          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// ===============================
  /// Sponsored Logic
  /// ===============================

  List<OfferEntity> _applySponsoredLogic(List<OfferEntity> offers) {
    List<OfferEntity> results = List.from(offers);

    /// حذف الإعلانات المنتهية
    results = results.where((offer) {
      /// SP دائمًا ظاهر
      if (offer.sp == true) {
        return true;
      }

      /// View Sponsored صالح
      if (offer.isViewSponsored == true && offer.remainingViews > 0) {
        return true;
      }

      /// إعلان عادي
      if (!offer.isViewSponsored) {
        return true;
      }

      return false;
    }).toList();

    /// ترتيب الإعلانات أولاً
    results.sort((a, b) {
      final aSponsored = a.sp == true || a.isViewSponsored == true;

      final bSponsored = b.sp == true || b.isViewSponsored == true;

      if (aSponsored && !bSponsored) {
        return -1;
      }

      if (!aSponsored && bSponsored) {
        return 1;
      }

      /// بعد sponsored
      return b.averageRating.compareTo(a.averageRating);
    });

    return results;
  }

  /// ===============================
  /// SORT
  /// ===============================
  void applySort(SortType type) {
    List<OfferEntity> sorted = List.from(state.results);

    switch (type) {
      case SortType.rating:
        sorted.sort((a, b) => b.averageRating.compareTo(a.averageRating));
        break;

      case SortType.experience:
        sorted.sort(
          (a, b) => b.yearsOfExperience.compareTo(a.yearsOfExperience),
        );
        break;

      case SortType.distance:
        sorted.sort((a, b) => a.distance.compareTo(b.distance));
        break;
    }

    emit(state.copyWith(results: sorted, selectedSort: type));
  }

  /// ===============================
  /// FILTER
  /// ===============================

  void applyFilter({
    required double minRating,
    required double maxRating,
    required int minExperience,
    required int maxExperience,
    required double minDistance,
    required double maxDistance,
  }) {
    final filtered = state.originalResults.where((offer) {
      final ratingValid =
          offer.averageRating >= minRating && offer.averageRating <= maxRating;

      final experienceValid =
          offer.yearsOfExperience >= minExperience &&
          offer.yearsOfExperience <= maxExperience;

      final distanceValid =
          offer.distance >= minDistance && offer.distance <= maxDistance;

      return ratingValid && experienceValid && distanceValid;
    }).toList();

    final finalList = _sortSponsoredWithShuffle(filtered);
    emit(
      state.copyWith(
        results: finalList,
        minRating: minRating,
        maxRating: maxRating,
        minExperience: minExperience,
        maxExperience: maxExperience,
        minDistance: minDistance,
        maxDistance: maxDistance,
      ),
    );
  }

  /// ===============================
  /// HISTORY
  /// ===============================

  Future<void> saveSearchHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();

    final key = _getUserHistoryKey();

    List<String> history = prefs.getStringList(key) ?? [];

    history.removeWhere(
      (item) => item.trim().toLowerCase() == query.trim().toLowerCase(),
    );

    history.insert(0, query);

    if (history.length > 10) {
      history = history.take(10).toList();
    }

    await prefs.setStringList(key, history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_getUserHistoryKey()) ?? [];
  }

  Future<void> removeHistoryItem(String item) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList(_getUserHistoryKey()) ?? [];

    history.remove(item);

    await prefs.setStringList(_getUserHistoryKey(), history);

    emit(state.copyWith(searchHistory: history));
  }

  Future<void> clearAllHistory() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_getUserHistoryKey());

    emit(state.copyWith(searchHistory: []));
  }

  Future<void> loadHistory() async {
    final history = await getSearchHistory();

    emit(state.copyWith(searchHistory: history));
  }
}
