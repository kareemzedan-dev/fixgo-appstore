import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecommendedOffersUseCase {
  final OffersRepo repo;

  GetRecommendedOffersUseCase(this.repo);

  Future<List<OfferEntity>> call() {
    return repo.getRecommendedOffers();
  }
}