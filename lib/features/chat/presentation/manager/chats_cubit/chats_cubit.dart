/// presentation/manager/chats_cubit/chats_cubit.dart

library;

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/chat/domain/use_cases/delete_chat_use_case.dart';

import '../../../domain/entities/chat_entity.dart';
import '../../../domain/use_cases/get_chats_use_case.dart';
import 'chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  final GetChatsUseCase getChatsUseCase;

  final DeleteChatUseCase deleteChatUseCase;

  ChatsCubit(this.getChatsUseCase, this.deleteChatUseCase)
    : super(ChatsInitial());

  StreamSubscription? _chatsSubscription;

  List<ChatEntity> _allChats = [];

  void getChats() {
    emit(ChatsLoading());

    _chatsSubscription?.cancel();

    _chatsSubscription = getChatsUseCase().listen(
      (chats) {
        _allChats = chats;

        emit(ChatsLoaded(chats));
      },
      onError: (e) {
        emit(ChatsFailure(e.toString()));
      },
    );
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await deleteChatUseCase(chatId);

      _allChats.removeWhere((chat) => chat.chatId == chatId);

      emit(ChatsLoaded(List.from(_allChats)));
    } catch (e) {
      emit(ChatsFailure(e.toString()));
    }
  }

  void searchChats(String query) {
    if (query.trim().isEmpty) {
      emit(ChatsLoaded(_allChats));
      return;
    }

    final filtered = _allChats.where((chat) {
      return chat.userName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(ChatsLoaded(filtered));
  }

  void refreshChats() {
    _chatsSubscription?.cancel();
    getChats();
  }

  void clearChats() {
    _chatsSubscription?.cancel();

    _allChats = [];

    emit(ChatsInitial());
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
