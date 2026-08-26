import 'package:injectable/injectable.dart';
import 'package:fixgo/features/offers/domain/entities/offer_entity.dart';
import 'package:fixgo/features/offers/domain/repos/offers_repo.dart';

@injectable
class SearchOffersUseCase {
  final OffersRepo repo;

  SearchOffersUseCase(this.repo);

  Future<List<OfferEntity>> call(String query) {
    return repo.searchOffers(query);
  }
}
