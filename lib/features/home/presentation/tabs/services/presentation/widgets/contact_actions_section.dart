import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class ContactActionsSection extends StatelessWidget {
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;
  final VoidCallback onChat;

  const ContactActionsSection({
    super.key,
    required this.onCall,
    required this.onWhatsapp,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r(20)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      /// ROW OF BUTTONS
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(
            color: ColorsManager.primaryColor,
            text: AppLocalizations.of(context).chatAction,
            icon: AssetsManager.chatBubbleOutline,
            onTap: onChat,
          ),
          _buildButton(
            color: Colors.green,
            text: AppLocalizations.of(context).whatsappAction,
            icon: AssetsManager.whatsapp,
            onTap: onWhatsapp,
          ),
          _buildButton(
            color: ColorsManager.info,
            text: AppLocalizations.of(context).callAction,
            icon: AssetsManager.call,
            onTap: onCall,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required String icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSizes.h(40),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.w(6)),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSizes.r(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ICON IMAGE
              Image.asset(
                icon,
                width: AppSizes.w(18),
                height: AppSizes.h(18),
                color: Colors.white, // يخليها أبيض زي التصميم
              ),
              SizedBox(width: AppSizes.w(8)),

              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.sp(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
