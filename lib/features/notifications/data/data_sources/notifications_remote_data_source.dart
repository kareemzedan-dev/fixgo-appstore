import 'package:fixgo/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Stream<List<NotificationModel>> listenNotifications(String userId);

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
