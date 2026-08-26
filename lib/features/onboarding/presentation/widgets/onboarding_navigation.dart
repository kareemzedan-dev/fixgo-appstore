import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class OnboardingNavigation extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const OnboardingNavigation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onPrevious != null)
            GestureDetector(
              onTap: onPrevious,
              child: Text(
                l10n.previous,
                style: TextStyle(
                  color: ColorsManager.darkGrey,
                  fontSize: AppSizes.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const Spacer(),
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: AppSizes.w(56),
              height: AppSizes.h(56),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorsManager.primaryColor,
                  width: AppSizes.w(3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: AppSizes.w(44),
                  height: AppSizes.h(44),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsManager.primaryColor,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: AppSizes.sp(14),
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
