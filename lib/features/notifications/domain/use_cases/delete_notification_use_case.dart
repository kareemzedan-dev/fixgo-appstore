import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@injectable
class DeleteNotificationUseCase {
  final NotificationsRepo repo;

  DeleteNotificationUseCase(this.repo);

  Future<void> call({required String userId, required String notificationId}) {
    return repo.deleteNotification(
      userId: userId,
      notificationId: notificationId,
    );
  }
}
