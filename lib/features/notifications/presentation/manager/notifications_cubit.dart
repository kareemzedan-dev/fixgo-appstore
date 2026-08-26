import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';
import 'package:fixgo/features/notifications/domain/use_cases/delete_all_notifications_use_case.dart';
import 'package:fixgo/features/notifications/domain/use_cases/delete_notification_use_case.dart';
import 'package:fixgo/features/notifications/domain/use_cases/listen_notifications_use_case.dart';
import 'package:fixgo/features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:fixgo/features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart';

@injectable
class NotificationsCubit extends Cubit<List<NotificationEntity>> {
  final ListenNotificationsUseCase listenNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllNotificationsAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final DeleteAllNotificationsUseCase deleteAllNotificationsUseCase;

  StreamSubscription<List<NotificationEntity>>? _subscription;

  NotificationsCubit(
    this.listenNotificationsUseCase,
    this.markNotificationAsReadUseCase,
    this.markAllNotificationsAsReadUseCase,
    this.deleteNotificationUseCase,
    this.deleteAllNotificationsUseCase,
  ) : super([]);

  int get unreadCount => state.where((n) => !n.isRead).length;

  void listen(String userId) {
    _subscription?.cancel();
    _subscription = listenNotificationsUseCase(userId).listen(emit);
  }

  Future<void> markAsRead(String userId, String notificationId) {
    return markNotificationAsReadUseCase(
      userId: userId,
      notificationId: notificationId,
    );
  }

  Future<void> markAllAsRead(String userId) {
    return markAllNotificationsAsReadUseCase(userId);
  }

  Future<void> deleteNotification(String userId, String notificationId) {
    return deleteNotificationUseCase(
      userId: userId,
      notificationId: notificationId,
    );
  }

  Future<void> deleteAllNotifications(String userId) {
    return deleteAllNotificationsUseCase(userId);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
