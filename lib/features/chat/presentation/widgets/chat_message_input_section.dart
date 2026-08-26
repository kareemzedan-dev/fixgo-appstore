import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ChatMessageInputSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onImage;
  final VoidCallback onDocument;

  const ChatMessageInputSection({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onImage,
    required this.onDocument,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.p16,
        AppSizes.p8,
        AppSizes.p16,
        AppSizes.p20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: AppSizes.h(48),
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E1E1E)
                    : const Color(0xFFF0F0F1),
                borderRadius: BorderRadius.circular(AppSizes.r(18)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: ColorsManager.primaryColor,
                      style: TextStyle(
                        color: ColorsManager.darkGrey,
                        fontSize: AppSizes.sp(14),
                        fontWeight: FontWeight.w500,
                      ),
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(
                          context,
                        )!.writeYourMessage,
                        fillColor: isDark
                            ? const Color(0xFF1E1E1E)
                            : const Color(0xFFF0F0F1),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: AppSizes.p12,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onDocument,
                    child: Image.asset(AssetsManager.file),
                  ),
                  SizedBox(width: AppSizes.w(12)),
                  GestureDetector(
                    onTap: onImage,
                    child: Image.asset(AssetsManager.gallery),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppSizes.w(12)),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: AppSizes.w(40),
              height: AppSizes.h(40),
              decoration: ShapeDecoration(
                color: ColorsManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                ),
              ),
              child: Center(
                child: Image.asset(
                  AssetsManager.send,
                  width: AppSizes.w(24),
                  height: AppSizes.h(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
