/// ===============================
/// reviews/domain/use_cases/get_reviews_use_case.dart
/// ===============================

library;

import 'package:injectable/injectable.dart';
import '../entities/review_entity.dart';
import '../repos/reviews_repo.dart';

@injectable
class GetReviewsUseCase {
  final ReviewsRepo repo;

  GetReviewsUseCase(this.repo);

  Future<List<ReviewEntity>> call(
    String offerId,
  ) {
    return repo.fetchReviews(
      offerId,
    );
  }
}