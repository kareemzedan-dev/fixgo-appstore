import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@injectable
class MarkAllNotificationsAsReadUseCase {
  final NotificationsRepo repo;

  MarkAllNotificationsAsReadUseCase(this.repo);

  Future<void> call(String userId) => repo.markAllAsRead(userId);
}
