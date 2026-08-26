import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class ChatAvatar extends StatelessWidget {
  final String userImage;

  const ChatAvatar({super.key, required this.userImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.r(30),
      backgroundColor: Colors.orange.shade100,
      backgroundImage: userImage.isNotEmpty ? NetworkImage(userImage) : null,
      child: userImage.isEmpty
          ? Icon(Icons.person, color: Colors.deepOrange, size: AppSizes.w(24))
          : null,
    );
  }
}
