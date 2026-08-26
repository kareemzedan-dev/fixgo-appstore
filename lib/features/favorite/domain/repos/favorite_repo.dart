import '../entities/favorite_offer_entity.dart';

abstract class FavoriteRepo {
  /// get favorite offers list
  Future<List<FavoriteOfferEntity>>
      getFavoriteOffers();

  /// add / remove favorite
  Future<void> toggleFavorite({
    required String offerId,
  });

  /// get favorite ids only
  Future<List<String>> getUserFavorites();
}