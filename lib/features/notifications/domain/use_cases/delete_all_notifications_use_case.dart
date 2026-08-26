import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@injectable
class DeleteAllNotificationsUseCase {
  final NotificationsRepo repo;

  DeleteAllNotificationsUseCase(this.repo);

  Future<void> call(String userId) => repo.deleteAllNotifications(userId);
}
