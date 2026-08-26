import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@injectable
class ListenNotificationsUseCase {
  final NotificationsRepo repo;

  ListenNotificationsUseCase(this.repo);

  Stream<List<NotificationEntity>> call(String userId) {
    return repo.listenNotifications(userId);
  }
}
