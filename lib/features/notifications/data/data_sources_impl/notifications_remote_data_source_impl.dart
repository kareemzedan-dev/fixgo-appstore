import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:fixgo/features/notifications/data/models/notification_model.dart';

@LazySingleton(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseFirestore firestore;

  NotificationsRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _items(String userId) {
    return firestore
        .collection('notifications')
        .doc(userId)
        .collection('items');
  }

  @override
  Stream<List<NotificationModel>> listenNotifications(String userId) {
    return _items(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) {
    return _items(userId).doc(notificationId).update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final snapshot = await _items(userId).get();
    for (final doc in snapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) {
    return _items(userId).doc(notificationId).delete();
  }

  @override
  Future<void> deleteAllNotifications(String userId) async {
    final snapshot = await _items(userId).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
