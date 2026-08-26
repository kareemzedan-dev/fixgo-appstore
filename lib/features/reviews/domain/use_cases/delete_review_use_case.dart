 

library;

import 'package:injectable/injectable.dart';
import '../entities/review_entity.dart';
import '../repos/reviews_repo.dart';

@injectable
class DeleteReviewUseCase {
  final ReviewsRepo repo;

  DeleteReviewUseCase(this.repo);

  Future<void> call({
    required String offerId,
    required ReviewEntity review,
  }) {
    return repo.deleteReview(
      offerId: offerId,
      review: review,
    );
  }
}