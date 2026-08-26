import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

/// domain/use_cases/mark_as_read_use_case.dart

@injectable
class MarkAsReadUseCase {
  final ChatRepo repo;

  MarkAsReadUseCase(this.repo);

  Future<void> call({required String chatId}) async {
    await repo.markAsRead(chatId: chatId);
  }
}
