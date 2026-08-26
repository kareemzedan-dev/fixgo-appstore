import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

import '../entities/offer_entity.dart';

@injectable
class GetMyServicesUseCase {
  final OffersRepo repo;

  GetMyServicesUseCase(this.repo);

  Future<List<OfferEntity>> call() {
    return repo.getMyServices();
  }
}
