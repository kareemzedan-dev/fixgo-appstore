 

library;

import 'package:injectable/injectable.dart';
import '../repos/offers_repo.dart';

@injectable
class UpdateOfferUseCase {
  final OffersRepo repo;

  UpdateOfferUseCase(
    this.repo,
  );

  Future<void> call({
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
    await repo.updateOffer(
      offerId: offerId,
      title: title,
      description: description,
      category: category,
      serviceCategory:
          serviceCategory,
      yearsOfExperience:
          yearsOfExperience,
      imageUrl: imageUrl,
      images: images,
      location: location
    );
  }
}