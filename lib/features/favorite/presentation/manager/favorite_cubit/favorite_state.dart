import 'package:fixgo/features/favorite/domain/entities/favorite_offer_entity.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<FavoriteOfferEntity> offers;

  FavoriteSuccess(this.offers);
}

class FavoritesLoadedState extends FavoriteState {
  final List<String> favoriteIds;

  FavoritesLoadedState(this.favoriteIds);
}

class FavoriteFailure extends FavoriteState {
  final String message;

  FavoriteFailure(this.message);
}
