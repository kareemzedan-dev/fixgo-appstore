import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class WorkerCardAttributes extends StatelessWidget {
  final String experience;
  final String distance;
  final bool showDistance;

  const WorkerCardAttributes({
    super.key,
    required this.experience,
    required this.distance,
    this.showDistance = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AssetsManager.experience,
              height: AppSizes.w(14),
              width: AppSizes.w(14),
            ),
            SizedBox(width: AppSizes.w(8) - AppSizes.w(4)), // AppSizes.w(4)
            Text(
              experience == "1"
                  ? AppLocalizations.of(context).oneYear
                  : experience == "2"
                  ? AppLocalizations.of(context).twoYears
                  : '$experience ${AppLocalizations.of(context).years}',
              style: TextStyle(
                fontSize: AppSizes.sp(12) - AppSizes.sp(1),
                fontWeight: FontWeight.w600,
                color: ColorsManager.darkGrey,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.h(8) - AppSizes.h(4)),
        if (showDistance)
          Row(
            children: [
              Image.asset(
                AssetsManager.distance,
                height: AppSizes.w(14),
                width: AppSizes.w(14),
                color: isDark ? ColorsManager.white : ColorsManager.black,
              ),
              SizedBox(width: AppSizes.w(8) - AppSizes.w(4)), // AppSizes.w(4)
              Text(
                distance,
                style: TextStyle(
                  fontSize: AppSizes.sp(12) - AppSizes.sp(1),
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.darkGrey,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
