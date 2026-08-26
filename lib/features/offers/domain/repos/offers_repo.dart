/// domain/repos/offers_repo.dart
library;

import 'package:image_picker/image_picker.dart';
import 'package:fixgo/features/auth/data/models/user_model.dart';

import '../entities/add_service_entity.dart';
import '../entities/boost_offer_status_entity.dart';
import '../entities/offer_entity.dart';

abstract class OffersRepo {
  Future<List<OfferEntity>> getOffers();

  Future<List<OfferEntity>> getNearbyOffers();

  Future<List<OfferEntity>> getRecommendedOffers();

  Future<OfferEntity> getOfferDetails({required String offerId});
  Stream<BoostOfferStatusEntity> watchBoostOfferStatus(String offerId);
  Future<Map<String, dynamic>> getUserData(String userId);
  Future<void> toggleFavorite({required String offerId});
  Future<List<OfferEntity>> getOffersByUser(String userId);
  Future<void> toggleFollow({required String userId});
  Future<List<OfferEntity>> getOffersByCategory(String category);
  Future<List<UserModel>> getFollowingUsersData();
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
  Future<List<OfferEntity>> getSimilarOffers({
    required String offerId,
    required String serviceCategory,
  });
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
  Future<List<OfferEntity>> searchOffers(String query);
  Future<List<String>> getFollowingUsers();
  Future<List<OfferEntity>> getMyServices();
  Future<List<OfferEntity>> getFollowingOffers();
  Future<void> addService({required AddServiceEntity service});
}
