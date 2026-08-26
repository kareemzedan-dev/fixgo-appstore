library;

import 'package:injectable/injectable.dart';

import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';

@injectable
class GetSimilarOffersUseCase {
  final OffersRepo repo;

  GetSimilarOffersUseCase(
    this.repo,
  );

  Future<List<OfferEntity>> call({
    required String offerId,
    required String serviceCategory,
  }) async {
    return await repo
        .getSimilarOffers(
      offerId: offerId,
      serviceCategory:
          serviceCategory,
    );
  }
}