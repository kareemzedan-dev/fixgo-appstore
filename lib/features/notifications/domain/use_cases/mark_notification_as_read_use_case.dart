import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationsRepo repo;

  MarkNotificationAsReadUseCase(this.repo);

  Future<void> call({required String userId, required String notificationId}) {
    return repo.markAsRead(userId: userId, notificationId: notificationId);
  }
}
