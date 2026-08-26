import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';
import '../entities/offer_entity.dart';

@injectable
class GetProviderServicesUseCase {
  final OffersRepo repository;

  GetProviderServicesUseCase(this.repository);

  Future<List<OfferEntity>> call(String userId) async {
    return await repository.getOffersByUser(userId);
  }
}
