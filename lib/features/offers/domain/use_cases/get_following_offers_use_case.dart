import 'package:injectable/injectable.dart';
import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';

@injectable
class GetFollowingOffersUseCase {
  final OffersRepo repo;

  GetFollowingOffersUseCase(this.repo);

  Future<List<OfferEntity>> call() {
    return repo.getFollowingOffers();
  }
}