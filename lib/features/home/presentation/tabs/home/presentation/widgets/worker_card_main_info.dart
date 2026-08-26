import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class WorkerCardMainInfo extends StatelessWidget {
  final String name;
  final String job;
  final double rating;
  final bool isMyService;
  final String experience;

  const WorkerCardMainInfo({
    super.key,
    required this.name,
    required this.job,
    required this.rating,
    required this.isMyService,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMyService)
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppSizes.sp(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(
          height: AppSizes.h(8) - AppSizes.h(4),
        ), // closest to AppSizes.h(6)

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isMyService)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.secondaryColor,
                        fontSize: AppSizes.sp(12) - AppSizes.sp(1),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: ColorsManager.star,
                          size: AppSizes.w(14),
                        ),
                        SizedBox(
                          width: AppSizes.w(8) - AppSizes.w(6),
                        ), // closest to AppSizes.w(2)
                        Text(
                          rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: AppSizes.sp(12) - AppSizes.sp(1),
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.darkGrey,
                          ),
                        ),
                        SizedBox(width: AppSizes.w(22) - AppSizes.w(12)), //
                        Row(
                          children: [
                            Image.asset(
                              AssetsManager.experience,
                              height: AppSizes.w(14),
                              width: AppSizes.w(14),
                            ),
                            SizedBox(
                              width: AppSizes.w(8) - AppSizes.w(4),
                            ), // AppSizes.w(4)
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
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: AppSizes.sp(14),
                          color: ColorsManager.darkGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (!isMyService) ...[
              SizedBox(
                width: AppSizes.w(8) - AppSizes.w(4),
              ), // closest to AppSizes.w(4)
              Icon(Icons.star, color: ColorsManager.star, size: AppSizes.w(14)),
              SizedBox(
                width: AppSizes.w(8) - AppSizes.w(6),
              ), // closest to AppSizes.w(2)
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: AppSizes.sp(12) - AppSizes.sp(1),
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.darkGrey,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
