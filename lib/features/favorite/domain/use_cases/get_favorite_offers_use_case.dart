import 'package:injectable/injectable.dart';

import '../entities/favorite_offer_entity.dart';
import '../repos/favorite_repo.dart';
@injectable
class GetFavoriteOffersUseCase {
  final FavoriteRepo repo;

  GetFavoriteOffersUseCase(this.repo);

  Future<List<FavoriteOfferEntity>> call() {
    return repo.getFavoriteOffers();
  }
}