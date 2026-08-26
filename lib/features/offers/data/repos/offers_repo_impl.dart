import 'package:image_picker/image_picker.dart';
import 'package:fixgo/features/auth/data/models/user_model.dart';
import 'package:fixgo/features/offers/data/models/add_service_model.dart';
import 'package:fixgo/features/offers/domain/entities/add_service_entity.dart';
import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';

import '../../domain/entities/offer_entity.dart';
import '../../domain/repos/offers_repo.dart';
import '../data_sources/offers_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OffersRepo)
class OffersRepoImpl implements OffersRepo {
  final OffersRemoteDataSource remote;

  OffersRepoImpl(this.remote);

  @override
  Future<List<OfferEntity>> getOffers() {
    return remote.getOffers();
  }

  @override
  Future<List<OfferEntity>> getNearbyOffers() {
    return remote.getNearbyOffers();
  }

  @override
  Future<OfferEntity> getOfferDetails({required String offerId}) {
    return remote.getOfferDetails(offerId);
  }

  @override
  Stream<BoostOfferStatusEntity> watchBoostOfferStatus(String offerId) {
    return remote.watchBoostOfferStatus(offerId);
  }

  @override
  Future<List<String>> getFollowingUsers() {
    return remote.getFollowingUsers();
  }

  @override
  Future<List<OfferEntity>> getFollowingOffers() {
    return remote.getFollowingOffers();
  }

  @override
  Future<void> addService({required AddServiceEntity service}) async {
    await remote.addService(service: AddServiceModel.fromEntity(service));
  }

  /// NEW
  @override
  Future<List<OfferEntity>> getRecommendedOffers() {
    return remote.getRecommendedOffers();
  }

  @override
  Future<void> toggleFavorite({required String offerId}) {
    return remote.toggleFavorite(offerId);
  }

  @override
  Future<void> toggleFollow({required String userId}) {
    return remote.toggleFollow(userId);
  }

  @override
  Future<void> countOfferView({
    required String offerId,
    String? offerOwnerId,
    String? userId,
  }) {
    return remote.countOfferView(
      offerId: offerId,
      offerOwnerId: offerOwnerId,
      userId: userId,
    );
  }

  @override
  Future<List<String>> uploadOfferImages({
    required List<XFile> images,
    required String folderName,
  }) {
    return remote.uploadOfferImages(images: images, folderName: folderName);
  }

  @override
  Future<String> uploadOfferImage({
    required XFile image,
    required String folderName,
  }) {
    return remote.uploadOfferImage(image: image, folderName: folderName);
  }

  @override
  Future<List<OfferEntity>> getOffersByCategory(String category) {
    return remote.getOffersByCategory(category);
  }

  @override
  Future<List<OfferEntity>> searchOffers(String query) {
    return remote.searchOffers(query);
  }

  @override
  Future<List<OfferEntity>> getMyServices() async {
    final result = await remote.getMyServices();

    return result; // OfferModel extends OfferEntity ✔
  }

  @override
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
  }) async {
    await remote.updateOffer(
      offerId: offerId,
      title: title,
      description: description,
      category: category,
      serviceCategory: serviceCategory,
      yearsOfExperience: yearsOfExperience,
      imageUrl: imageUrl,
      images: images,
      location: location,
    );
  }

  @override
  Future<List<OfferEntity>> getSimilarOffers({
    required String offerId,
    required String serviceCategory,
  }) {
    return remote.getSimilarOffers(
      offerId: offerId,
      serviceCategory: serviceCategory,
    );
  }

  @override
  Future<List<OfferEntity>> getOffersByUser(String userId) {
    return remote.getOffersByUser(userId);
  }

  @override
  Future<Map<String, dynamic>> getUserData(String userId) {
    return remote.getUserData(userId);
  }

  @override
  Future<List<UserModel>> getFollowingUsersData() {
    return remote.getFollowingUsersData();
  }
}
