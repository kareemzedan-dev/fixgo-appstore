import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

/// domain/use_cases/send_document_use_case.dart

@injectable
class SendDocumentUseCase {
  final ChatRepo repo;

  SendDocumentUseCase(this.repo);

  Future<void> call({required String otherUserId}) async {
    await repo.sendDocument(otherUserId: otherUserId);
  }
}
