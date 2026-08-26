/// ===============================
/// reviews/presentation/manager/reviews_state.dart
/// ===============================

library;

import 'package:fixgo/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;

  ReviewsLoaded(this.reviews);
}

class ReviewsFailure extends ReviewsState {
  final String message;

  ReviewsFailure(this.message);
}
