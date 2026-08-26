/// domain/use_cases/get_chats_use_case.dart
library;

import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/repos/chat_repo.dart';

import '../entities/chat_entity.dart';

@injectable
class GetChatsUseCase {
  final ChatRepo repo;

  GetChatsUseCase(this.repo);

  Stream<List<ChatEntity>> call() {
    return repo.getChats();
  }
}
