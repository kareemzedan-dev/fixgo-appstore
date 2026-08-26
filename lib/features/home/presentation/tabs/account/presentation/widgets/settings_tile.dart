import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class SettingsItem {
  final String title;
  final String subtitle;
  final String icon;
  final void Function()? onTap;
  final Widget? trailing;

  /// جديد
  final bool showVerificationBadge;

  SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.trailing,

    /// جديد
    this.showVerificationBadge = false,
  });
}

class SettingsTile extends StatelessWidget {
  final SettingsItem item;

  const SettingsTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        width: AppSizes.sp(36),
        height: AppSizes.sp(36),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(.2) : Colors.grey.shade300,
            width: 1.2,
          ),
          color: isDark ? const Color(0Xff1E1E1E) : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          item.icon,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),

      title: Row(
        children: [
          Expanded(
            child: Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.sp(14),
              ),
            ),
          ),

          /// يظهر فقط في حالة التوثيق
          if (item.showVerificationBadge) ...[
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w(14),
                vertical: AppSizes.h(4),
              ),
              decoration: BoxDecoration(
                color: isDark ? const Color(0Xff1E1E1E) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                AppLocalizations.of(context).requiredBadge,
                style: TextStyle(
                  color: const Color(0xFFD98B1F),
                  fontSize: AppSizes.sp(12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: AppSizes.w(16)),
          ],
        ],
      ),

      subtitle: Text(
        item.subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppSizes.sp(12),
          color: ColorsManager.darkGrey,
        ),
      ),

      trailing:
          item.trailing ??
          Icon(
            CupertinoIcons.chevron_forward,
            size: AppSizes.sp(16),
            color: ColorsManager.darkGrey,
          ),

      tileColor: isDark ? const Color(0Xff2A2A2A) : Colors.white,
      splashColor: isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.black.withOpacity(0.05),
      onTap: item.onTap,
    );
  }
}
