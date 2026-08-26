import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ChatImageMessage extends StatelessWidget {
  final String image;
  final bool isMe;

  const ChatImageMessage({super.key, required this.image, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: AppSizes.w(220),
        height: AppSizes.h(210),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r(18)),
          border: Border.all(
            color: const Color(0xFF1E3A6D),
            width: AppSizes.w(2),
          ),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
