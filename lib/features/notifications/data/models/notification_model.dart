import 'package:fixgo/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? titleAr;
  final String? titleEn;
  final String? bodyAr;
  final String? bodyEn;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final String? otherUserId;
  final String? chatId;
  final String? offerId;
  final String? referenceId;
  final String? conversationId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.titleAr,
    this.titleEn,
    this.bodyAr,
    this.bodyEn,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.otherUserId,
    this.chatId,
    this.offerId,
    this.referenceId,
    this.conversationId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      id: id,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      titleAr: map['title_ar'] as String?,
      titleEn: map['title_en'] as String?,
      bodyAr: map['body_ar'] as String?,
      bodyEn: map['body_en'] as String?,
      type: map['type'] ?? '',
      isRead: map['isRead'] ?? false,
      otherUserId: map['otherUserId'] as String?,
      chatId: map['chatId'] as String?,
      offerId: map['offerId'] as String?,
      referenceId: map['reference_id'] as String?,
      conversationId: map['conversation_id'] as String?,
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      titleAr: titleAr,
      titleEn: titleEn,
      bodyAr: bodyAr,
      bodyEn: bodyEn,
      type: type,
      isRead: isRead,
      createdAt: createdAt,
      otherUserId: otherUserId,
      chatId: chatId,
      offerId: offerId,
      referenceId: referenceId,
      conversationId: conversationId,
    );
  }
}
