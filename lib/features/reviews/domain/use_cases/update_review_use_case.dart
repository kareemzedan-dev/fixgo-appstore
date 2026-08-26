/// ===============================================
/// domain/use_cases/update_review_use_case.dart
/// ===============================================

library;

import 'package:injectable/injectable.dart';
import '../entities/review_entity.dart';
import '../repos/reviews_repo.dart';

@injectable
class UpdateReviewUseCase {
  final ReviewsRepo repo;

  UpdateReviewUseCase(
    this.repo,
  );

  Future<void> call({
    required String offerId,
    required ReviewEntity review,
  }) async {
    await repo.updateReview(
      offerId: offerId,
      review: review,
    );
  }
}