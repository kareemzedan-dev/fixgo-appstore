/// presentation/manager/chat_details_cubit/chat_details_state.dart
library;

import '../../../domain/entities/message_entity.dart';

abstract class ChatDetailsState {}

class ChatDetailsInitial
    extends ChatDetailsState {}

class ChatDetailsLoading
    extends ChatDetailsState {}

class ChatDetailsLoaded
    extends ChatDetailsState {
  final List<MessageEntity> messages;

  ChatDetailsLoaded(
    this.messages,
  );
}

class ChatDetailsFailure
    extends ChatDetailsState {
  final String message;

  ChatDetailsFailure(
    this.message,
  );
}