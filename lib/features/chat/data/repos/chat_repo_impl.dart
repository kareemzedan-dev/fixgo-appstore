/// data/repo_impl/chat_repo_impl.dart
library;

import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../data_sources/chat_remote_data_source.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepoImpl(this.remoteDataSource);

  @override
  Stream<List<ChatEntity>> getChats() {
    return remoteDataSource.getChats();
  }

  @override
  Stream<List<MessageEntity>> getMessages({required String chatId}) {
    return remoteDataSource.getMessages(chatId: chatId);
  }

  @override
  Future<void> sendMessage({
    required String otherUserId,
    required String text,
    String type = "text",
  }) async {
    await remoteDataSource.sendMessage(
      otherUserId: otherUserId,
      text: text,
      type: type,
    );
  }

  @override
  Future<void> sendImage({required String otherUserId}) async {
    await remoteDataSource.sendImage(otherUserId: otherUserId);
  }

  @override
  Future<void> sendDocument({required String otherUserId}) async {
    await remoteDataSource.sendDocument(otherUserId: otherUserId);
  }

  @override
  Future<void> markAsRead({required String chatId}) async {
    await remoteDataSource.markAsRead(chatId: chatId);
  }

  @override
  Future<void> deleteChat({required String chatId}) async {
    await remoteDataSource.deleteChat(chatId: chatId);
  }
}
