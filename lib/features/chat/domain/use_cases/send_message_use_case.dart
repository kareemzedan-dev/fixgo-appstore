import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

/// domain/use_cases/send_message_use_case.dart

@injectable
class SendMessageUseCase {
  final ChatRepo repo;

  SendMessageUseCase(this.repo);

  Future<void> call({
    required String otherUserId,
    required String text,
    String type = "text",
  }) async {
    await repo.sendMessage(otherUserId: otherUserId, text: text, type: type);
  }
}
