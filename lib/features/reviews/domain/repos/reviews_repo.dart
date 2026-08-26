library;

import '../entities/review_entity.dart';

abstract class ReviewsRepo {
  Future<List<ReviewEntity>> fetchReviews(String offerId);
  Future<ReviewEntity?> getUserReview({
    required String offerId,
    required String userId,
  });

  Future<void> updateReview({
    required String offerId,
    required ReviewEntity review,
  });
  Future<void> addReview({
    required String offerId,
    required ReviewEntity review,
  });

  Future<void> deleteReview({
    required String offerId,
    required ReviewEntity review,
  });
  Future<void> createReviewNotification({
    required String offerOwnerId,
    required String offerId,
    required String reviewerId,
    required String reviewerName,
  });
}
