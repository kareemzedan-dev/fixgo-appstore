import 'package:fixgo/features/favorite/data/models/favorite_offer_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoriteOfferModel>> getFavoriteOffers();

  Future<void> toggleFavorite(String offerId);

  Future<List<String>> getUserFavorites();
}
