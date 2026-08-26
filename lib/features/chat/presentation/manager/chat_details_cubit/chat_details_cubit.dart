/// presentation/manager/chat_details_cubit/chat_details_cubit.dart

library;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_messages_use_case.dart';
import '../../../domain/use_cases/send_document_use_case.dart';
import '../../../domain/use_cases/send_image_use_case.dart';
import '../../../domain/use_cases/send_message_use_case.dart';
import '../../../domain/use_cases/mark_as_read_use_case.dart';
import 'chat_details_state.dart';

@injectable
class ChatDetailsCubit
    extends Cubit<ChatDetailsState> {
  final GetMessagesUseCase
      getMessagesUseCase;

  final SendMessageUseCase
      sendMessageUseCase;

  final SendImageUseCase
      sendImageUseCase;

  final SendDocumentUseCase
      sendDocumentUseCase;

  final MarkAsReadUseCase
      markAsReadUseCase;

  StreamSubscription? _messagesSub;

  ChatDetailsCubit(
    this.getMessagesUseCase,
    this.sendMessageUseCase,
    this.sendImageUseCase,
    this.sendDocumentUseCase,
    this.markAsReadUseCase,
  ) : super(
          ChatDetailsInitial(),
        );

  void getMessages(
    String chatId,
  ) {
    emit(
      ChatDetailsLoading(),
    );

    _messagesSub?.cancel();

    _messagesSub =
        getMessagesUseCase(
      chatId: chatId,
    ).listen(
      (messages) {
        emit(
          ChatDetailsLoaded(
            messages,
          ),
        );
      },
      onError: (e) {
        emit(
          ChatDetailsFailure(
            e.toString(),
          ),
        );
      },
    );
  }

  Future<void> sendMessage({
    required String otherUserId,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    try {
      await sendMessageUseCase(
        otherUserId: otherUserId,
        text: text,
      );
    } catch (e) {
      emit(
        ChatDetailsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> sendImage({
    required String otherUserId,
  }) async {
    try {
      await sendImageUseCase(
        otherUserId: otherUserId,
      );
    } catch (e) {
      emit(
        ChatDetailsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> sendDocument({
    required String otherUserId,
  }) async {
    try {
      await sendDocumentUseCase(
        otherUserId: otherUserId,
      );
    } catch (e) {
      emit(
        ChatDetailsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> markAsRead({
    required String chatId,
  }) async {
    await markAsReadUseCase(
      chatId: chatId,
    );
  }

  @override
  Future<void> close() {
    _messagesSub?.cancel();
    return super.close();
  }
}