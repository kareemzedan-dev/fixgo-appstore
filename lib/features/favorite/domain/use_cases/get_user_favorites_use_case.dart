import 'package:injectable/injectable.dart';

import '../repos/favorite_repo.dart';

@injectable
class GetUserFavoritesUseCase {
  final FavoriteRepo repo;

  GetUserFavoritesUseCase(this.repo);

  Future<List<String>> call() {
    return repo.getUserFavorites();
  }
}