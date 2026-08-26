import 'package:injectable/injectable.dart';

import '../repos/offers_repo.dart';

@injectable
class CountOfferViewUseCase {
  final OffersRepo repo;

  CountOfferViewUseCase(this.repo);

  Future<void> call({
    required String offerId,
    String? offerOwnerId,
    String? userId,
  }) {
    return repo.countOfferView(
      offerId: offerId,
      offerOwnerId: offerOwnerId,
      userId: userId,
    );
  }
}
