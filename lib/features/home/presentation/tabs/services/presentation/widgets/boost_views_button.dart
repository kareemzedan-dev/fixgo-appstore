import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class BoostViewsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final bool isExpanded;

  const BoostViewsButton({
    super.key,
    required this.onPressed,
    this.width,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: ColorsManager.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Row(
              children: [
                /// أيقونة المشاهدات
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0x33F0F0F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.stacked_bar_chart_sharp,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                /// النصوص
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).boostViews,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.sp(16),
                          fontWeight: FontWeight.w500,
                          height: 1.60,
                        ),
                      ),

                      Text(
                        AppLocalizations.of(context).boostViewsSubtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.sp(12),
                          fontWeight: FontWeight.w500,
                          height: 1.60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
