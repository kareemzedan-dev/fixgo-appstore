library;

import '../models/review_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<List<ReviewModel>> fetchReviews(String offerId);
  Future<ReviewModel?> getUserReview({
    required String offerId,
    required String userId,
  });

  Future<void> updateReview({
    required String offerId,
    required ReviewModel review,
  });
  Future<void> addReview({
    required String offerId,
    required ReviewModel review,
  });

  Future<void> deleteReview({
    required String offerId,
    required ReviewModel review,
  });
  Future<void> createReviewNotification({
    required String offerOwnerId,
    required String offerId,
    required String reviewerId,
    required String reviewerName,
  });
}
