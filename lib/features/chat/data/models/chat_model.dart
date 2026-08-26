/// data/models/chat_model.dart

library;

import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.chatId,
    required super.otherUserId,
    required super.userName,
    required super.userImage,
    required super.lastMessage,
    required super.lastDate,
    required super.unreadCount,
  });

  factory ChatModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ChatModel(
      chatId:
          map["chatId"] ?? "",

      otherUserId:
          map["otherUserId"] ?? "",

      userName:
          map["userName"] ?? "",

      userImage:
          map["userImage"] ?? "",

      lastMessage:
          map["lastMessage"] ?? "",

      lastDate:
          map["lastDate"] ?? "",

      /// مهم جدًا
      /// لم نعد نقرأ unreadCount من هنا
      /// لأنه أصبح unreadCounts map داخل Firestore
      /// والقراءة الحقيقية تتم داخل getChats()
      unreadCount: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "chatId": chatId,

      "otherUserId":
          otherUserId,

      "userName":
          userName,

      "userImage":
          userImage,

      "lastMessage":
          lastMessage,

      "lastDate":
          lastDate,

      /// مهم جدًا
      /// لا تحفظ unreadCount هنا
      /// لأن النظام الجديد يعتمد على:
      ///
      /// unreadCounts: {
      ///   uid1: 0,
      ///   uid2: 3
      /// }
      ///
      /// وليس:
      ///
      /// unreadCount: 3
    };
  }
}