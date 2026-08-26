import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/offers/domain/use_cases/get_following_users_data_use_case.dart';
import 'package:fixgo/features/offers/domain/use_cases/get_my_services_use_case.dart';
import 'package:fixgo/features/offers/presentation/manager/search_cubit/search_state.dart';

import '../../../domain/entities/offer_entity.dart';
import '../../../domain/use_cases/get_nearby_offers_use_case.dart';
import '../../../domain/use_cases/get_offers_use_case.dart';
import '../../../domain/use_cases/get_recommended_offers_use_case.dart';
import '../../../domain/use_cases/get_similar_offers_use_case.dart';

/// الجديد 👇
import '../../../domain/use_cases/toggle_follow_use_case.dart';
import '../../../domain/use_cases/get_following_users_use_case.dart';
import '../../../domain/use_cases/get_following_offers_use_case.dart';

import 'offers_state.dart';

@injectable
class OffersCubit extends Cubit<OffersState> {
  final GetOffersUseCase getOffersUseCase;
  final GetNearbyOffersUseCase getNearbyOffersUseCase;
  final GetRecommendedOffersUseCase getRecommendedOffersUseCase;
  final GetSimilarOffersUseCase getSimilarOffersUseCase;
  final GetMyServicesUseCase getMyServicesUseCase;

  /// الجديد 👇
  final ToggleFollowUseCase toggleFollowUseCase;
  final GetFollowingUsersDataUseCase getFollowingUsersDataUseCase;
  final GetFollowingUsersUseCase getFollowingUsersUseCase;
  final GetFollowingOffersUseCase getFollowingOffersUseCase;
  final AppSessionCubit appSessionCubit;

  OffersCubit(
    this.getOffersUseCase,
    this.getNearbyOffersUseCase,
    this.getRecommendedOffersUseCase,
    this.getSimilarOffersUseCase,

    /// الجديد
    this.toggleFollowUseCase,
    this.getFollowingUsersUseCase,
    this.getFollowingOffersUseCase,
    this.appSessionCubit,
    this.getMyServicesUseCase,
    this.getFollowingUsersDataUseCase,
  ) : super(const OffersState());
  List<OfferEntity> _originalFollowing = [];
  SearchState searchState = SearchState();

  /// ===================================
  /// INIT
  /// ===================================

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await getOffers();
      await getNearbyOffers();
      await getRecommendedOffers();

      /// الجديد
      await getFollowingUsers();
      await getFollowingOffers();

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> getFollowingUsersData() async {
    try {
      final users = await getFollowingUsersDataUseCase();

      emit(state.copyWith(followingUsers: users));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getMyServices() async {
    try {
      final result = await getMyServicesUseCase();

      emit(state.copyWith(myServices: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// ===================================
  /// GET ALL OFFERS
  /// ===================================
  Future<void> getOffers() async {
    try {
      final result = await getOffersUseCase();

      /// 👇 هات المستخدم
      final user = appSessionCubit.currentUser;

      if (user == null || user.latitude == null) {
        emit(state.copyWith(allOffers: result));
        return;
      }

      final userLat = user.latitude!;
      final userLng = user.longitude!;

      /// 👇 احسب المسافة لكل offer
      final updated = result.map((offer) {
        final distance = Geolocator.distanceBetween(
          userLat,
          userLng,
          offer.latitude,
          offer.longitude,
        );

        return offer.copyWith(distance: distance);
      }).toList();

      emit(state.copyWith(allOffers: updated));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getNearbyOffers() async {
    try {
      final result = await getNearbyOffersUseCase();

      final user = appSessionCubit.currentUser;
      if (user == null || user.latitude == null) {
        /// 👇 الأصل فيه الإعلانات
        final original = result;

        /// 👇 الهوم بدون إعلانات
        final filtered = result
            .where((offer) => offer.isSponsored != true)
            .toList();

        emit(
          state.copyWith(
            nearbyOffers: filtered,
            nearbyOffersOriginal: original,
          ),
        );

        return;
      }

      final userLat = user.latitude!;
      final userLng = user.longitude!;

      final updated = result.map((offer) {
        final distance = Geolocator.distanceBetween(
          userLat,
          userLng,
          offer.latitude,
          offer.longitude,
        );

        return offer.copyWith(distance: distance);
      }).toList();

      final original = updated;

      final filtered = updated
          .where((offer) => offer.isSponsored != true)
          .toList();

      emit(
        state.copyWith(nearbyOffers: filtered, nearbyOffersOriginal: original),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getRecommendedOffers() async {
    try {
      final result = await getRecommendedOffersUseCase();

      final user = appSessionCubit.currentUser;
      if (user == null || user.latitude == null) {
        final original = result;

        final filtered = result
            .where((offer) => offer.isSponsored != true)
            .toList();

        emit(
          state.copyWith(
            recommendedOffers: filtered,
            recommendedOffersOriginal: original,
          ),
        );

        return;
      }
      final userLat = user.latitude!;
      final userLng = user.longitude!;

      final updated = result.map((offer) {
        final distance = Geolocator.distanceBetween(
          userLat,
          userLng,
          offer.latitude,
          offer.longitude,
        );

        return offer.copyWith(distance: distance);
      }).toList();

      final original = updated;

      final filtered = updated
          .where((offer) => offer.isSponsored != true)
          .toList();

      emit(
        state.copyWith(
          recommendedOffers: filtered,
          recommendedOffersOriginal: original,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getSimilarOffers({
    required String offerId,
    required String serviceCategory,
  }) async {
    try {
      emit(state.copyWith(isSimilarLoading: true));

      final result = await getSimilarOffersUseCase(
        offerId: offerId,
        serviceCategory: serviceCategory,
      );

      emit(state.copyWith(similarOffers: result, isSimilarLoading: false));
    } catch (e) {
      emit(state.copyWith(isSimilarLoading: false, error: e.toString()));
    }
  }

  /// ===================================
  /// FOLLOW SYSTEM
  /// ===================================

  Future<void> toggleFollow(String userId) async {
    await toggleFollowUseCase(userId);

    await getFollowingUsers();
    await getFollowingOffers();
  }

  Future<void> getFollowingUsers() async {
    try {
      final result = await getFollowingUsersUseCase();

      emit(state.copyWith(followingIds: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getFollowingOffers() async {
    try {
      final result = await getFollowingOffersUseCase();

      _originalFollowing = result; // ✅ حفظ الأصل

      emit(state.copyWith(followingOffers: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void sortFollowing(SortType type) {
    searchState = searchState.copyWith(selectedSort: type);

    final sorted = [..._originalFollowing];

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

    emit(state.copyWith(followingOffers: sorted));
  }

  void filterFollowing({
    required double minRating,
    required double maxRating,
    required int minExperience,
    required int maxExperience,
    required double minDistance,
    required double maxDistance,
  }) {
    searchState = searchState.copyWith(
      minRating: minRating,
      maxRating: maxRating,
      minExperience: minExperience,
      maxExperience: maxExperience,
      minDistance: minDistance,
      maxDistance: maxDistance,
    );

    final filtered = _originalFollowing.where((offer) {
      final rating = offer.averageRating;
      final exp = offer.yearsOfExperience;

      final distanceKm = offer.distance / 1000;

      return rating >= minRating &&
          rating <= maxRating &&
          exp >= minExperience &&
          exp <= maxExperience &&
          distanceKm >= minDistance &&
          distanceKm <= maxDistance;
    }).toList();

    emit(state.copyWith(followingOffers: filtered));
  }

  /// ===================================
  /// APPLY FILTER
  /// ===================================

  void applyFilter({
    String? category,
    String? service,
    double? minRating,
    double? maxRating,
    int? minExperience,
    int? maxExperience,
    double? minDistance,
    double? maxDistance,
  }) {
    final List<OfferEntity> originalOffers = state.allOffers;

    final filtered = originalOffers.where((offer) {
      final matchesCategory =
          category == null || category.isEmpty || offer.category == category;

      final matchesService =
          service == null ||
          service.isEmpty ||
          offer.serviceCategory == service;

      final matchesRating =
          (minRating == null || offer.averageRating >= minRating) &&
          (maxRating == null || offer.averageRating <= maxRating);

      final matchesExperience =
          (minExperience == null || offer.yearsOfExperience >= minExperience) &&
          (maxExperience == null || offer.yearsOfExperience <= maxExperience);

      final offerDistanceKm = offer.distance / 1000;

      final matchesDistance =
          (minDistance == null || offerDistanceKm >= minDistance) &&
          (maxDistance == null || offerDistanceKm <= maxDistance);

      return matchesCategory &&
          matchesService &&
          matchesRating &&
          matchesExperience &&
          matchesDistance;
    }).toList();

    emit(state.copyWith(nearbyOffers: filtered, recommendedOffers: filtered));
  }

  /// ===================================
  /// RESET FILTER
  /// ===================================

  void resetFilter() {
    emit(
      state.copyWith(
        nearbyOffers: state.allOffers,
        recommendedOffers: state.allOffers,
      ),
    );
  }

  void searchOffers(String query, {required bool isNear}) {
    final source = isNear
        ? state.nearbyOffersOriginal
        : state.recommendedOffersOriginal;

    /// 👇 تنظيف النص
    final cleanedQuery = query.trim().toLowerCase();

    /// 👇 لو فاضي رجع كل الداتا
    if (cleanedQuery.isEmpty) {
      if (isNear) {
        emit(state.copyWith(nearbyOffers: source));
      } else {
        emit(state.copyWith(recommendedOffers: source));
      }

      return;
    }

    final filtered = source.where((offer) {
      final name = (offer.userName ?? "").toLowerCase();

      final job = (offer.profession ?? "").toLowerCase();

      final title = offer.title.toLowerCase();

      return name.contains(cleanedQuery) ||
          job.contains(cleanedQuery) ||
          title.contains(cleanedQuery);
    }).toList();

    if (isNear) {
      emit(state.copyWith(nearbyOffers: filtered));
    } else {
      emit(state.copyWith(recommendedOffers: filtered));
    }
  }

  void resetSearch({required bool isNear}) {
    if (isNear) {
      emit(state.copyWith(nearbyOffers: state.nearbyOffersOriginal));
    } else {
      emit(state.copyWith(recommendedOffers: state.recommendedOffersOriginal));
    }
  }
}
