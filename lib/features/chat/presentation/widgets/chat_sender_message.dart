import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ChatSenderMessage extends StatefulWidget {
  final String text;
  final DateTime createdAt;

  const ChatSenderMessage({
    super.key,
    required this.text,
    required this.createdAt,
  });

  @override
  State<ChatSenderMessage> createState() => ChatSenderMessageState();
}

class ChatSenderMessageState extends State<ChatSenderMessage> {
  bool showTime = false;

  String formatTime(DateTime date) {
    return DateFormat('hh:mm a', 'ar').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          setState(() => showTime = !showTime);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.62,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p18,
                  vertical: AppSizes.p14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A6D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.r(18)),
                    topRight: Radius.circular(AppSizes.r(18)),
                    bottomLeft: Radius.circular(AppSizes.r(18)),
                    bottomRight: Radius.circular(AppSizes.r(4)),
                  ),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.sp16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (showTime)
              Padding(
                padding: EdgeInsets.only(top: AppSizes.p6, right: AppSizes.p6),
                child: Text(
                  formatTime(widget.createdAt),
                  style: TextStyle(
                    fontSize: AppSizes.sp12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
