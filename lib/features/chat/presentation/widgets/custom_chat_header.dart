import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';

class CustomChatHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onEdit;

  final bool showBackButton;
  final bool showEditButton;
  final Widget? actionIcon;
  const CustomChatHeader({
    super.key,
    required this.title,
    this.onBack,
    this.onEdit,
    this.showBackButton = true,
    this.showEditButton = true,
    this.actionIcon, // 👈 الجديد
  });
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        SizedBox(width: AppSizes.w(16)),
        if (!kIsWeb)
          showBackButton
              ? InkWell(
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                    ),
                  ),
                )
              : const SizedBox(width: 48, height: 48),
        if (kIsWeb) SizedBox(width: 48, height: 48),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.sp(16),
                fontWeight: FontWeight.w700,
                height: 1.60,
              ),
            ),
          ),
        ),

        /// زر التعديل من AssetsManager
        showEditButton
            ? InkWell(
                onTap: onEdit,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E5E5)),
                  ),

                  child: Center(
                    child:
                        actionIcon ??
                        Image.asset(
                          AssetsManager.edit,
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                  ),
                ),
              )
            : const SizedBox(width: 48, height: 48),

        SizedBox(width: AppSizes.w(16)),
      ],
    );
  }
}
