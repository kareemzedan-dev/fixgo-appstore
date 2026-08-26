 
import 'package:injectable/injectable.dart';

import '../entities/offer_entity.dart';
import '../repos/offers_repo.dart';
@injectable
class GetOffersByCategoryUseCase {
  final OffersRepo repo;

  GetOffersByCategoryUseCase(
    this.repo,
  );

  Future<List<OfferEntity>> call(
    String category,
  ) {
    return repo.getOffersByCategory(
      category,
    );
  }
}