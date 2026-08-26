import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';

import '../../../domain/entities/favorite_offer_entity.dart';
import '../../../domain/use_cases/get_favorite_offers_use_case.dart';
import '../../../domain/use_cases/get_user_favorites_use_case.dart';
import '../../../domain/use_cases/toggle_favorite_use_case.dart';
import 'favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoriteOffersUseCase getFavoriteOffersUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetUserFavoritesUseCase getUserFavoritesUseCase;

  FavoriteCubit(
    this.getFavoriteOffersUseCase,
    this.toggleFavoriteUseCase,
    this.getUserFavoritesUseCase,
  ) : super(FavoriteInitial());

  List<String> favoriteIds = [];

  /// ✅ النسخة الأصلية
  List<FavoriteOfferEntity> _allOffers = [];

  /// ✅ النسخة المعروضة
  List<FavoriteOfferEntity> _currentOffers = [];

  Future<void> init() async {
    await loadFavorites();
    await getFavoriteOffers();
  }

  /// =========================
  /// LOAD FAVORITES IDS
  /// =========================
  Future<void> loadFavorites() async {
    try {
      favoriteIds = await getUserFavoritesUseCase();

      emit(FavoritesLoadedState(List<String>.from(favoriteIds)));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  /// =========================
  /// TOGGLE FAVORITE
  /// =========================
  Future<void> toggleFavorite(String offerId) async {
    try {
      await toggleFavoriteUseCase(offerId);

      if (favoriteIds.contains(offerId)) {
        favoriteIds.remove(offerId);
      } else {
        favoriteIds.add(offerId);
      }

      emit(FavoritesLoadedState(List<String>.from(favoriteIds)));

      await getFavoriteOffers();
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  bool isFavorite(String offerId) {
    return favoriteIds.contains(offerId);
  }

  /// =========================
  /// GET FAVORITE OFFERS
  /// =========================
  Future<void> getFavoriteOffers() async {
    if (isClosed) return;

    emit(FavoriteLoading());

    try {
      final result = await getFavoriteOffersUseCase();

      if (isClosed) return;

      _allOffers = result;
      _currentOffers = result;

      emit(FavoriteSuccess(_currentOffers));
    } catch (e) {
      if (isClosed) return;

      emit(FavoriteFailure(e.toString()));
    }
  }

  /// =========================
  /// SORT
  /// =========================
  void sortOffers(SortType type) {
    List<FavoriteOfferEntity> sorted = List.from(_currentOffers);

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
        return; // ❌ تجاهل
    }

    _currentOffers = sorted;
    emit(FavoriteSuccess(_currentOffers));
  }

  /// =========================
  /// FILTER
  /// =========================
  void filterOffers({int? minExperience}) {
    List<FavoriteOfferEntity> filtered = List.from(_allOffers);

    if (minExperience != null) {
      filtered = filtered
          .where((e) => e.yearsOfExperience >= minExperience)
          .toList();
    }

    _currentOffers = filtered;

    emit(FavoriteSuccess(_currentOffers));
  }

  /// =========================
  /// RESET FILTER
  /// =========================
  void resetFilters() {
    _currentOffers = List.from(_allOffers);
    emit(FavoriteSuccess(_currentOffers));
  }
}
