import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_state.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_floating_action_button.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_item_card.dart';
import 'package:fixgo/features/chat/presentation/widgets/chats_header_section.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/search_and_filter.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => ChatsViewState();
}

class ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ChatFloatingActionButton(),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSizes.h(16)),

            ChatsHeaderSection(),

            SizedBox(height: AppSizes.h(20)),
            SearchAndFilter(
              openSearchPageOnly: false,
              onSearch: (value) {
                context.read<ChatsCubit>().searchChats(value);
              },
              onFilter: () {},
              showfiler: false,
            ),

            SizedBox(height: AppSizes.h(16)),

            Expanded(
              child: BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, state) {
                  if (state is ChatsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ChatsFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is ChatsLoaded) {
                    if (state.chats.isEmpty) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!.noChats),
                      );
                    }

                    return ListView.separated(
                      itemCount: state.chats.length,

                      separatorBuilder: (_, __) =>
                          SizedBox(height: AppSizes.h(12)),

                      itemBuilder: (context, index) {
                        final chat = state.chats[index];

                        return ChatItemCard(
                          chatId: chat.chatId,

                          otherUserId: chat.otherUserId,

                          userName: chat.userName,

                          userImage: chat.userImage,

                          lastMessage: chat.lastMessage,

                          lastDate: chat.lastDate,

                          /// الجديد
                          unreadCount: chat.unreadCount,
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
