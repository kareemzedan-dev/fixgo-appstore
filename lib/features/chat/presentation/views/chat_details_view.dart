import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/features/chat/presentation/manager/chat_details_cubit/chat_details_cubit.dart';
import 'package:fixgo/features/chat/presentation/manager/chat_details_cubit/chat_details_state.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_messages_list.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_message_input_section.dart';

class ChatDetailsView extends StatefulWidget {
  /// بدل chatId أصبح otherUserId
  final String otherUserId;

  const ChatDetailsView({super.key, required this.otherUserId});

  @override
  State<ChatDetailsView> createState() => ChatDetailsViewState();
}

class ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  DateTime? currentVisibleDate;

  late String chatId;

  @override
  void initState() {
    super.initState();

    /// توليد chatId داخليًا
    final currentUserId = context.read<AppSessionCubit>().currentUser!.uid;

    final ids = [currentUserId, widget.otherUserId]..sort();

    chatId = "${ids[0]}_${ids[1]}";

    context.read<ChatDetailsCubit>().getMessages(chatId);

    context.read<ChatDetailsCubit>().markAsRead(chatId: chatId);

    scrollController.addListener(_handleScrollDate);
  }

  @override
  void dispose() {
    messageController.dispose();

    scrollController.removeListener(_handleScrollDate);

    scrollController.dispose();

    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage() async {
    await context.read<ChatDetailsCubit>().sendMessage(
      otherUserId: widget.otherUserId,
      text: messageController.text,
    );

    messageController.clear();
  }

  void _handleScrollDate() {
    final state = context.read<ChatDetailsCubit>().state;

    if (state is! ChatDetailsLoaded) {
      return;
    }

    if (state.messages.isEmpty) {
      return;
    }

    const itemHeight = 90.0;

    final index = (scrollController.offset / itemHeight).floor();

    if (index < 0 || index >= state.messages.length) {
      return;
    }

    final newDate = state.messages[index].createdAt;

    if (currentVisibleDate == null ||
        currentVisibleDate!.day != newDate.day ||
        currentVisibleDate!.month != newDate.month ||
        currentVisibleDate!.year != newDate.year) {
      setState(() {
        currentVisibleDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSizes.h(16)),

            CustomChatHeader(
              title: AppLocalizations.of(context)!.chatTitle,
              showEditButton: false,
            ),

            SizedBox(height: AppSizes.h(16)),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
                child: BlocConsumer<ChatDetailsCubit, ChatDetailsState>(
                  listener: (context, state) {
                    if (state is ChatDetailsLoaded) {
                      scrollToBottom();
                    }

                    if (state is ChatDetailsFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },

                  builder: (context, state) {
                    if (state is ChatDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ChatDetailsLoaded) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: Text(AppLocalizations.of(context)!.noMessages),
                        );
                      }

                      return ChatMessagesList(
                        scrollController: scrollController,

                        messages: state.messages,

                        currentVisibleDate:
                            currentVisibleDate ??
                            state.messages.first.createdAt,
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),

            ChatMessageInputSection(
              controller: messageController,

              onSend: sendMessage,

              onImage: () {
                context.read<ChatDetailsCubit>().sendImage(
                  otherUserId: widget.otherUserId,
                );
              },

              onDocument: () {
                context.read<ChatDetailsCubit>().sendDocument(
                  otherUserId: widget.otherUserId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
