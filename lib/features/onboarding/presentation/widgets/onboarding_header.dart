import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class OnboardingHeader extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onSkip;

  const OnboardingHeader({
    super.key,
    required this.title,
    required this.description,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onSkip,
                child: Text(
                  l10n.skip,
                  style: TextStyle(
                    color: ColorsManager.darkGrey,
                    fontSize: AppSizes.sp(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.h(20)),
          Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp(24),
              fontWeight: FontWeight.bold,
              color: const Color(0xff1E3A5F),
            ),
          ),
          SizedBox(height: AppSizes.h(12)),
          Text(
            description,
            style: TextStyle(fontSize: AppSizes.sp(14), color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
