// ===============================
// data/data_sources/offers_remote_data_source.dart
// ===============================

import 'package:image_picker/image_picker.dart';
import 'package:fixgo/features/auth/data/models/user_model.dart';
import 'package:fixgo/features/offers/data/models/add_service_model.dart';
import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';

import '../models/offer_model.dart';

abstract class OffersRemoteDataSource {
  Future<List<OfferModel>> getOffers();

  Future<List<OfferModel>> getNearbyOffers();

  Future<List<OfferModel>> getRecommendedOffers();

  /// NEW
  Future<OfferModel> getOfferDetails(String offerId);
  Stream<BoostOfferStatusEntity> watchBoostOfferStatus(String offerId);

  Future<List<UserModel>> getFollowingUsersData();
  Future<Map<String, dynamic>> getUserData(String userId);
  Future<void> addService({required AddServiceModel service});
  Future<void> toggleFavorite(String offerId);
  Future<List<OfferEntity>> getOffersByUser(String userId);
  Future<List<OfferEntity>> getSimilarOffers({
    required String offerId,
    required String serviceCategory,
  });
  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String description,
    required String category,
    required String serviceCategory,
    required int yearsOfExperience,
    required String imageUrl,
    required List<String> images,
    required String location,
  });
  Future<List<OfferEntity>> getOffersByCategory(String category);
  Future<void> toggleFollow(String userId);
  Future<List<OfferModel>> searchOffers(String query);
  Future<void> countOfferView({
    required String offerId,
    String? offerOwnerId,
    String? userId,
  });
  Future<List<String>> uploadOfferImages({
    required List<XFile> images,
    required String folderName,
  });
  Future<String> uploadOfferImage({
    required XFile image,
    required String folderName,
  });
  Future<List<String>> getFollowingUsers();
  Future<List<OfferEntity>> getMyServices();
  Future<List<OfferEntity>> getFollowingOffers();
}
