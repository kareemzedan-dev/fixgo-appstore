import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String headerTitle;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final VoidCallback? onClose;
  final VoidCallback? onHeaderTap;
  const AuthHeader({
    super.key,
    required this.title,
    required this.headerTitle,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.onClose,
    this.onHeaderTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onClose ?? () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   decoration: ShapeDecoration(
            //     shape: RoundedRectangleBorder(
            //       side: BorderSide(width: 1, color: const Color(0xFFE8E8E8)),
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //   ),
            //   child: GestureDetector(
            //     onTap: onHeaderTap,
            //     child: Text(
            //       headerTitle,
            //       style: TextStyle(
            //         fontSize: AppSizes.sp(12),
            //         fontFamily: 'Alyamama',
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),

        SizedBox(height: AppSizes.h(32)),

        Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.sp(24),
            fontWeight: FontWeight.w700,
            height: 1.60,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: AppSizes.sp(14),
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ],
      ],
    );
  }
}
