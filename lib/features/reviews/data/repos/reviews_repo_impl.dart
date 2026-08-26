library;

import 'package:injectable/injectable.dart';

import '../../domain/entities/review_entity.dart';
import '../../domain/repos/reviews_repo.dart';
import '../data_sources/reviews_remote_data_source.dart';
import '../models/review_model.dart';

@LazySingleton(as: ReviewsRepo)
class ReviewsRepoImpl implements ReviewsRepo {
  final ReviewsRemoteDataSource remoteDataSource;

  ReviewsRepoImpl({required this.remoteDataSource});

  @override
  Future<void> createReviewNotification({
    required String offerOwnerId,
    required String offerId,
    required String reviewerId,
    required String reviewerName,
  }) {
    return remoteDataSource.createReviewNotification(
      offerOwnerId: offerOwnerId,
      offerId: offerId,
      reviewerId: reviewerId,
      reviewerName: reviewerName,
    );
  }

  /// =====================================
  /// FETCH REVIEWS
  /// =====================================

  @override
  Future<List<ReviewEntity>> fetchReviews(String offerId) async {
    return await remoteDataSource.fetchReviews(offerId);
  }

  /// =====================================
  /// ADD REVIEW
  /// =====================================

  @override
  Future<void> addReview({
    required String offerId,
    required ReviewEntity review,
  }) async {
    final model = ReviewModel(
      id: review.id,

      offerId: review.offerId,

      userId: review.userId,

      /// الجديد
      userName: review.userName,

      content: review.content,

      createdAt: review.createdAt,

      rating: review.rating,

      parentId: review.parentId,
    );

    await remoteDataSource.addReview(offerId: offerId, review: model);
  }

  /// =====================================
  /// DELETE REVIEW
  /// =====================================

  @override
  Future<void> deleteReview({
    required String offerId,
    required ReviewEntity review,
  }) async {
    final model = ReviewModel(
      id: review.id,

      offerId: review.offerId,

      userId: review.userId,

      /// الجديد
      userName: review.userName,

      content: review.content,

      createdAt: review.createdAt,

      rating: review.rating,

      parentId: review.parentId,
    );

    await remoteDataSource.deleteReview(offerId: offerId, review: model);
  }

  @override
  Future<ReviewEntity?> getUserReview({
    required String offerId,
    required String userId,
  }) {
    return remoteDataSource.getUserReview(offerId: offerId, userId: userId);
  }

  @override
  Future<void> updateReview({
    required String offerId,
    required ReviewEntity review,
  }) async {
    /// لازم نحول من ReviewEntity → ReviewModel

    final model = ReviewModel(
      id: review.id,

      offerId: review.offerId,

      userId: review.userId,

      /// مهم جدًا
      userName: review.userName,

      content: review.content,

      createdAt: review.createdAt,

      rating: review.rating,

      parentId: review.parentId,
    );

    await remoteDataSource.updateReview(offerId: offerId, review: model);
  }
}
