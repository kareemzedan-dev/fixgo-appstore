import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';

class ProviderProfileHeader extends StatelessWidget {
  final String title;
  final bool isFollowing;
  final VoidCallback onFollow;

  const ProviderProfileHeader({
    super.key,
    required this.title,
    required this.isFollowing,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomChatHeader(
      title: title,
      actionIcon: InkWell(
        onTap: onFollow,
        child: isFollowing
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
                size: AppSizes.w(18),
              )
            : Image.asset(
                AssetsManager.personAddAlt,
                height: AppSizes.w(16),
                width: AppSizes.w(16),
                fit: BoxFit.contain,
                color: isDark ? Colors.white : Colors.black,
              ),
      ),
    );
  }
}
