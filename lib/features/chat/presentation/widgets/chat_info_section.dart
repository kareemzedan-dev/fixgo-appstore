import 'package:flutter/material.dart';
import 'package:fixgo/core/helper/format_chat_date.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ChatInfoSection extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String lastDate;

  const ChatInfoSection({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.lastDate,
  });

  String _formatLastMessage(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    final lower = message.toLowerCase();

    if (lower.contains("firebasestorage") &&
        (lower.contains(".jpg") ||
            lower.contains(".jpeg") ||
            lower.contains(".png") ||
            lower.contains(".webp"))) {
      return l10n.photoAttachment;
    }

    if (lower.contains("firebasestorage") &&
        (lower.contains(".pdf") ||
            lower.contains(".doc") ||
            lower.contains(".docx") ||
            lower.contains(".xls") ||
            lower.contains(".xlsx") ||
            lower.contains(".ppt") ||
            lower.contains(".pptx") ||
            lower.contains(".txt"))) {
      return l10n.docAttachment;
    }

    if (lower.contains("firebasestorage")) {
      return l10n.fileAttachment;
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSizes.sp(16),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              formatChatDate(lastDate),
              style: TextStyle(
                color: ColorsManager.darkGrey,
                fontSize: AppSizes.sp(12),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.h(8)),
        Text(
          _formatLastMessage(context, lastMessage),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: ColorsManager.darkGrey,
            fontSize: AppSizes.sp(13),
          ),
        ),
      ],
    );
  }
}
