import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

import '../entities/message_entity.dart';

@injectable
class GetMessagesUseCase {
  final ChatRepo repo;

  GetMessagesUseCase(this.repo);

  Stream<List<MessageEntity>> call({required String chatId}) {
    return repo.getMessages(chatId: chatId);
  }
}
