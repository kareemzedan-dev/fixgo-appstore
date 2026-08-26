import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsRepo {
  Stream<List<NotificationEntity>> listenNotifications(String userId);

  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  });

  Future<void> markAllAsRead(String userId);

  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  });

  Future<void> deleteAllNotifications(String userId);
}
