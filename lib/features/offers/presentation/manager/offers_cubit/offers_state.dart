import 'package:fixgo/features/auth/data/models/user_model.dart';

import '../../../domain/entities/offer_entity.dart';
import 'package:equatable/equatable.dart';

class OffersState extends Equatable {
  final bool isLoading;

  /// تحميل الخدمات المشابهة
  final bool isSimilarLoading;

  final String? error;
  final List<OfferEntity> nearbyOffersOriginal;
  final List<OfferEntity> recommendedOffersOriginal;
  final List<OfferEntity> allOffers;
  final List<OfferEntity> nearbyOffers;
  final List<OfferEntity> recommendedOffers;
  final List<UserModel> followingUsers;

  /// الخدمات المشابهة
  final List<OfferEntity> similarOffers;

  /// الفيفوريت
  final List<String> favoriteIds;
  final List<OfferEntity> myServices;

  /// الجديد 👇
  final List<String> followingIds;
  final List<OfferEntity> followingOffers;

  const OffersState({
    this.isLoading = false,
    this.isSimilarLoading = false,
    this.error,
    this.allOffers = const [],
    this.nearbyOffers = const [],
    this.recommendedOffers = const [],
    this.similarOffers = const [],
    this.favoriteIds = const [],
    this.nearbyOffersOriginal = const [],
    this.recommendedOffersOriginal = const [],
    this.followingUsers = const [],

    /// الجديد
    this.followingIds = const [],
    this.followingOffers = const [],
    this.myServices = const [],
  });

  OffersState copyWith({
    bool? isLoading,
    bool? isSimilarLoading,
    String? error,
    List<OfferEntity>? allOffers,
    List<OfferEntity>? nearbyOffers,
    List<OfferEntity>? recommendedOffers,
    List<OfferEntity>? similarOffers,
    List<String>? favoriteIds,
    List<OfferEntity>? myServices,
    List<OfferEntity>? nearbyOffersOriginal,
    List<OfferEntity>? recommendedOffersOriginal,

    /// الجديد
    List<String>? followingIds,
    List<OfferEntity>? followingOffers,
    List<UserModel>? followingUsers,
  }) {
    return OffersState(
      isLoading: isLoading ?? this.isLoading,
      isSimilarLoading: isSimilarLoading ?? this.isSimilarLoading,
      error: error,
      allOffers: allOffers ?? this.allOffers,
      nearbyOffers: nearbyOffers ?? this.nearbyOffers,
      recommendedOffers: recommendedOffers ?? this.recommendedOffers,
      similarOffers: similarOffers ?? this.similarOffers,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      myServices: myServices ?? this.myServices,

      /// الجديد
      followingIds: followingIds ?? this.followingIds,
      followingOffers: followingOffers ?? this.followingOffers,
      nearbyOffersOriginal: nearbyOffersOriginal ?? this.nearbyOffersOriginal,
      recommendedOffersOriginal:
          recommendedOffersOriginal ?? this.recommendedOffersOriginal,
      followingUsers: followingUsers ?? this.followingUsers,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSimilarLoading,
    error,

    allOffers,

    nearbyOffers,
    nearbyOffersOriginal,

    recommendedOffers,
    recommendedOffersOriginal,

    similarOffers,

    favoriteIds,

    followingIds,
    followingOffers,

    followingUsers,

    myServices,
  ];
}
