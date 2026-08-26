import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_date_badge.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_sender_message.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_receiver_message.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_image_message.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_document_message.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ChatMessagesList extends StatelessWidget {
  final ScrollController scrollController;
  final List<dynamic> messages;
  final DateTime currentVisibleDate;

  const ChatMessagesList({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.currentVisibleDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatDateBadge(date: currentVisibleDate),
        SizedBox(height: AppSizes.h(16)),
        Expanded(
          child: ListView.separated(
            controller: scrollController,
            itemCount: messages.length,
            separatorBuilder: (_, __) => SizedBox(height: AppSizes.h(16)),
            itemBuilder: (context, index) {
              final message = messages[index];
              final currentUserId =
                  context.read<AppSessionCubit>().currentUser?.uid ?? '';
              final isMe = message.senderId == currentUserId;

              if (message.type == "image") {
                return ChatImageMessage(image: message.text, isMe: isMe);
              }
              if (message.type == "document") {
                return ChatDocumentMessage(
                  fileUrl: message.fileUrl,
                  fileName: message.fileName,
                  fileSize: message.fileSize,
                  extension: message.fileExtension,
                  isMe: isMe,
                );
              }
              if (isMe) {
                return ChatSenderMessage(
                  text: message.text,
                  createdAt: message.createdAt,
                );
              }
              return ChatReceiverMessage(
                text: message.text,
                createdAt: message.createdAt,
              );
            },
          ),
        ),
      ],
    );
  }
}
