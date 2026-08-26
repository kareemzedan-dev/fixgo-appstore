import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ChatReceiverMessage extends StatefulWidget {
  final String text;
  final DateTime createdAt;

  const ChatReceiverMessage({
    super.key,
    required this.text,
    required this.createdAt,
  });

  @override
  State<ChatReceiverMessage> createState() => ChatReceiverMessageState();
}

class ChatReceiverMessageState extends State<ChatReceiverMessage> {
  bool showTime = false;

  String formatTime(DateTime date) {
    return DateFormat('hh:mm a', 'ar').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          setState(() => showTime = !showTime);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.r(18)),
                    topRight: Radius.circular(AppSizes.r(18)),
                    bottomLeft: Radius.circular(AppSizes.r(4)),
                    bottomRight: Radius.circular(AppSizes.r(18)),
                  ),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: AppSizes.sp(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (showTime)
              Padding(
                padding: EdgeInsets.only(top: AppSizes.p6, left: AppSizes.p6),
                child: Text(
                  formatTime(widget.createdAt),
                  style: TextStyle(
                    fontSize: AppSizes.sp(12),
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
