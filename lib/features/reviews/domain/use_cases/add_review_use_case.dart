 

library;

import 'package:injectable/injectable.dart';
import '../entities/review_entity.dart';
import '../repos/reviews_repo.dart';

@injectable
class AddReviewUseCase {
  final ReviewsRepo repo;

  AddReviewUseCase(this.repo);

  Future<void> call({
    required String offerId,
    required ReviewEntity review,
  }) {
    return repo.addReview(
      offerId: offerId,
      review: review,
    );
  }
}