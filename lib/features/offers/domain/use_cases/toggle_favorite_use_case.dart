import 'package:injectable/injectable.dart';

import '../repos/offers_repo.dart';
@injectable
class ToggleFavoriteUseCase {
  final OffersRepo repo;

  ToggleFavoriteUseCase(this.repo);

  Future<void> call(String offerId) {
    return repo.toggleFavorite(
      offerId: offerId,
    );
  }
}