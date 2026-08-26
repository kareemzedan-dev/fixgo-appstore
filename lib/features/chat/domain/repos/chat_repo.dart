
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepo {
  Stream<List<ChatEntity>> getChats();

  Stream<List<MessageEntity>> getMessages({
    required String chatId,
  });

  Future<void> sendMessage({
    required String otherUserId,
    required String text,
    String type = "text",
  });

  Future<void> sendImage({
    required String otherUserId,
  });
 

  Future<void> sendDocument({
    required String otherUserId,
  });

  Future<void> markAsRead({
    required String chatId,
  });

  Future<void> deleteChat({
    required String chatId,
  });
}