import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_avatar.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_info_section.dart';
import 'package:fixgo/features/chat/presentation/widgets/chat_unread_indicator.dart';

class ChatItemCard extends StatelessWidget {
  final String chatId;

  /// مهم جدًا
  /// هذا هو المستخدم الحقيقي للطرف الآخر
  final String otherUserId;

  final String userName;
  final String userImage;
  final String lastMessage;
  final String lastDate;
  final int unreadCount;

  const ChatItemCard({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.userName,
    required this.userImage,
    required this.lastMessage,
    required this.lastDate,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
      child: InkWell(
        onTap: () {
          if (kIsWeb) {
            context.go("/chat-details/$otherUserId");
          } else {
            context.push("/chat-details/$otherUserId");
          }
        },
        child: Container(
          padding: EdgeInsets.all(AppSizes.p14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? const Color(0Xff1E1E1E) : Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(AppSizes.r(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: AppSizes.r(10),
                offset: Offset(0, AppSizes.h(4)),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(height: AppSizes.h(10)),

              ChatAvatar(userImage: userImage),

              SizedBox(width: AppSizes.w(12)),

              Expanded(
                child: ChatInfoSection(
                  userName: userName,
                  lastMessage: lastMessage,
                  lastDate: lastDate,
                ),
              ),

              SizedBox(width: AppSizes.w(12)),

              ChatUnreadIndicator(
                unreadCount: unreadCount,
                onDelete: () async {
                  await context.read<ChatsCubit>().deleteChat(chatId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
