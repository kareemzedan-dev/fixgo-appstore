import 'package:injectable/injectable.dart';

import '../repos/favorite_repo.dart';

@injectable
class ToggleFavoriteUseCase {
  final FavoriteRepo repo;

  ToggleFavoriteUseCase(this.repo);

  Future<void> call(
    String offerId,
  ) {
    return repo.toggleFavorite(
      offerId: offerId,
    );
  }
}