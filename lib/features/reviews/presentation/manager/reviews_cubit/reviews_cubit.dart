library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/reviews/domain/entities/review_entity.dart';
import 'package:fixgo/features/reviews/domain/use_cases/add_review_use_case.dart';
import 'package:fixgo/features/reviews/domain/use_cases/create_review_notification_use_case.dart';
import 'package:fixgo/features/reviews/domain/use_cases/delete_review_use_case.dart';
import 'package:fixgo/features/reviews/domain/use_cases/get_reviews_use_case.dart';
import 'package:fixgo/features/reviews/domain/use_cases/get_user_review_use_case.dart';
import 'package:fixgo/features/reviews/domain/use_cases/update_review_use_case.dart';

import 'reviews_state.dart';

@injectable
class ReviewsCubit extends Cubit<ReviewsState> {
  final GetReviewsUseCase getReviewsUseCase;

  final AddReviewUseCase addReviewUseCase;

  final DeleteReviewUseCase deleteReviewUseCase;

  /// الجديد
  final GetUserReviewUseCase getUserReviewUseCase;

  /// الجديد
  final UpdateReviewUseCase updateReviewUseCase;
  final CreateReviewNotificationUseCase createReviewNotificationUseCase;

  ReviewsCubit(
    this.getReviewsUseCase,
    this.addReviewUseCase,
    this.deleteReviewUseCase,

    /// الجديد
    this.getUserReviewUseCase,

    /// الجديد
    this.updateReviewUseCase,
    this.createReviewNotificationUseCase,
  ) : super(ReviewsInitial());

  /// =====================================
  /// FETCH REVIEWS
  /// =====================================

  Future<void> fetchReviews(String offerId) async {
    emit(ReviewsLoading());

    try {
      final result = await getReviewsUseCase(offerId);

      emit(ReviewsLoaded(result));
    } catch (e) {
      emit(ReviewsFailure(e.toString()));
    }
  }

  /// =====================================
  /// ADD REVIEW
  /// =====================================

  Future<void> addReview({
    required String offerId,
    required String offerOwnerId,
    required ReviewEntity review,
  }) async {
    await addReviewUseCase(offerId: offerId, review: review);
    await _createReviewNotification(
      offerOwnerId: offerOwnerId,
      offerId: offerId,
      review: review,
    );

    await fetchReviews(offerId);
  }

  /// =====================================
  /// DELETE REVIEW
  /// =====================================

  Future<void> deleteReview({
    required String offerId,
    required ReviewEntity review,
  }) async {
    await deleteReviewUseCase(offerId: offerId, review: review);

    await fetchReviews(offerId);
  }

  /// =====================================
  /// GET USER REVIEW
  /// المستخدم يقيّم مرة واحدة فقط
  /// =====================================

  Future<ReviewEntity?> getUserReview({
    required String offerId,
    required String userId,
  }) async {
    return await getUserReviewUseCase(offerId: offerId, userId: userId);
  }

  /// =====================================
  /// UPDATE REVIEW
  /// لو المستخدم قيّم قبل كده
  /// =====================================

  Future<void> updateReview({
    required String offerId,
    required String offerOwnerId,
    required ReviewEntity review,
  }) async {
    await updateReviewUseCase(offerId: offerId, review: review);
    await _createReviewNotification(
      offerOwnerId: offerOwnerId,
      offerId: offerId,
      review: review,
    );

    await fetchReviews(offerId);
  }

  Future<void> _createReviewNotification({
    required String offerOwnerId,
    required String offerId,
    required ReviewEntity review,
  }) {
    return createReviewNotificationUseCase(
      offerOwnerId: offerOwnerId,
      offerId: offerId,
      reviewerId: review.userId,
      reviewerName: review.userName,
    );
  }
}
