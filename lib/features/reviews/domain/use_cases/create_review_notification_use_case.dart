import 'package:injectable/injectable.dart';
import 'package:fixgo/features/reviews/domain/repos/reviews_repo.dart';

@injectable
class CreateReviewNotificationUseCase {
  final ReviewsRepo repo;

  CreateReviewNotificationUseCase(this.repo);

  Future<void> call({
    required String offerOwnerId,
    required String offerId,
    required String reviewerId,
    required String reviewerName,
  }) {
    return repo.createReviewNotification(
      offerOwnerId: offerOwnerId,
      offerId: offerId,
      reviewerId: reviewerId,
      reviewerName: reviewerName,
    );
  }
}
