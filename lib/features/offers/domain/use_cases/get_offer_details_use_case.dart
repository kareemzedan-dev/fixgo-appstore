// ===============================
// domain/use_cases/get_offer_details_use_case.dart
// ===============================

import 'package:injectable/injectable.dart';

import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';

@injectable
class GetOfferDetailsUseCase {
  final OffersRepo repo;

  GetOfferDetailsUseCase(
    this.repo,
  );

  Future<OfferEntity> call({
    required String offerId,
  }) {
    return repo.getOfferDetails(
      offerId: offerId,
    );
  }
}