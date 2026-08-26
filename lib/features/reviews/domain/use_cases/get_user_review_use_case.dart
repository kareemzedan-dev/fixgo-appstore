/// ===============================================
/// domain/use_cases/get_user_review_use_case.dart
/// ===============================================

library;

import 'package:injectable/injectable.dart';
import '../entities/review_entity.dart';
import '../repos/reviews_repo.dart';

@injectable
class GetUserReviewUseCase {
  final ReviewsRepo repo;

  GetUserReviewUseCase(
    this.repo,
  );

  Future<ReviewEntity?> call({
    required String offerId,
    required String userId,
  }) async {
    return await repo.getUserReview(
      offerId: offerId,
      userId: userId,
    );
  }
}