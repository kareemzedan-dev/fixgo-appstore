
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatModel>> getChats();

  Stream<List<MessageModel>> getMessages({
    required String chatId,
  });

  Future<void> sendMessage({
    required String otherUserId,
    required String text,
    required String type,
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