import 'package:injectable/injectable.dart';

import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';
@injectable
class GetNearbyOffersUseCase {
  final OffersRepo repo;

  GetNearbyOffersUseCase(this.repo);

  Future<List<OfferEntity>> call() {
    return repo.getNearbyOffers();
  }
}