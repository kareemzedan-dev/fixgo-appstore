/// domain/entities/chat_entity.dart

class ChatEntity {
  final String chatId;

  /// المستخدم الآخر في المحادثة
  final String otherUserId;

  final String userName;
  final String userImage;
  final String lastMessage;
  final String lastDate;

  /// عدد الرسائل غير المقروءة
  /// الخاصة بالمستخدم الحالي فقط
  final int unreadCount;

  const ChatEntity({
    required this.chatId,
    required this.otherUserId,
    required this.userName,
    required this.userImage,
    required this.lastMessage,
    required this.lastDate,
    required this.unreadCount,
  });
}