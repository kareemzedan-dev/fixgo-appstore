import 'package:injectable/injectable.dart';

import '../../domain/entities/favorite_offer_entity.dart';
import '../../domain/repos/favorite_repo.dart';
import '../data_sources/favorite_remote_data_source.dart';

@Injectable(as: FavoriteRepo)
class FavoriteRepoImpl
    implements FavoriteRepo {
  final FavoriteRemoteDataSource remote;

  FavoriteRepoImpl(this.remote);

  @override
  Future<List<FavoriteOfferEntity>>
      getFavoriteOffers() {
    return remote.getFavoriteOffers();
  }

  @override
  Future<void> toggleFavorite({
    required String offerId,
  }) {
    return remote.toggleFavorite(
      offerId,
    );
  }

  @override
  Future<List<String>>
      getUserFavorites() {
    return remote.getUserFavorites();
  }
}