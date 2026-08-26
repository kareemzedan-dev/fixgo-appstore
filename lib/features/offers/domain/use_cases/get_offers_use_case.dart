import 'package:injectable/injectable.dart';

import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';
@injectable
class GetOffersUseCase {
  final OffersRepo repo;

  GetOffersUseCase(this.repo);

  Future<List<OfferEntity>> call() {
    return repo.getOffers();
  }
}