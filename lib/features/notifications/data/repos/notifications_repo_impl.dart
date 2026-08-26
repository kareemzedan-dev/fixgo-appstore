import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/domain/repos/notifications_repo.dart';

@LazySingleton(as: NotificationsRepo)
class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepoImpl(this.remoteDataSource);

  @override
  Stream<List<NotificationEntity>> listenNotifications(String userId) {
    return remoteDataSource
        .listenNotifications(userId)
        .map((list) => list.map((e) => e.toEntity()).toList());
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) {
    return remoteDataSource.markAsRead(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> markAllAsRead(String userId) {
    return remoteDataSource.markAllAsRead(userId);
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) {
    return remoteDataSource.deleteNotification(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> deleteAllNotifications(String userId) {
    return remoteDataSource.deleteAllNotifications(userId);
  }
}
