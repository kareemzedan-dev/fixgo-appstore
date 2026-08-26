import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

@injectable
class DeleteChatUseCase {
  final ChatRepo repository;

  DeleteChatUseCase(this.repository);

  Future<void> call(String chatId) {
    return repository.deleteChat(chatId: chatId);
  }
}
