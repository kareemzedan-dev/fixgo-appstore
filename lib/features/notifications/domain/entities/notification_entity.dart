class NotificationEntity {
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

  const NotificationEntity({
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

  String localizedTitle(String languageCode) {
    if (languageCode == 'en') {
      final value = titleEn;
      if (value != null && value.isNotEmpty) return value;
    } else {
      final value = titleAr;
      if (value != null && value.isNotEmpty) return value;
    }
    return title;
  }

  String localizedBody(String languageCode) {
    if (languageCode == 'en') {
      final value = bodyEn;
      if (value != null && value.isNotEmpty) return value;
    } else {
      final value = bodyAr;
      if (value != null && value.isNotEmpty) return value;
    }
    return body;
  }
}
