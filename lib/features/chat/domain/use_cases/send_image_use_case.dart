import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

/// domain/use_cases/send_image_use_case.dart
@injectable
class SendImageUseCase {
  final ChatRepo repo;

  SendImageUseCase(this.repo);

  Future<void> call({required String otherUserId}) async {
    await repo.sendImage(otherUserId: otherUserId);
  }
}
