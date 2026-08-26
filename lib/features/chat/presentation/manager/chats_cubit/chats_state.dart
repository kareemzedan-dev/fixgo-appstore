/// presentation/manager/chats_cubit/chats_state.dart
library;

import '../../../domain/entities/chat_entity.dart';

abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<ChatEntity> chats;

  ChatsLoaded(this.chats);
}

class ChatsFailure extends ChatsState {
  final String message;

  ChatsFailure(this.message);
}