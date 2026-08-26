import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/entities/boost_offer_status_entity.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class WatchBoostOfferStatusUseCase {
  final OffersRepo repo;

  WatchBoostOfferStatusUseCase(this.repo);

  Stream<BoostOfferStatusEntity> call(String offerId) {
    return repo.watchBoostOfferStatus(offerId);
  }
}
