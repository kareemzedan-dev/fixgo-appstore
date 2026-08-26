import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/onboarding/presentation/widgets/bottom_gradient_overlay.dart';
import 'package:fixgo/features/onboarding/presentation/widgets/onboarding_indicator.dart';
import 'package:fixgo/features/onboarding/presentation/widgets/onboarding_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int currentIndex;
  final int totalPages;
  final bool isLast;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.totalPages,
    this.isLast = false,
    required this.onSkip,
    required this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Stack(
      children: [
        Positioned.fill(child: BottomGradientOverlay()),
        Positioned(
          top: 50,
          child: TextButton(
            onPressed: onSkip,
            child: Text(
              AppLocalizations.of(context).skip,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSizes.w(400),
                  height: AppSizes.h(400),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Circle
                      Container(
                        width: AppSizes.w(300),
                        height: AppSizes.h(300),
                        decoration: BoxDecoration(
                          color: Color(0xFFD3E2FF), // Your circle color
                          shape: BoxShape.circle,
                        ),
                      ),

                      // Image from assets
                      Image.asset(
                        image,
                        width: AppSizes.w(300),
                        height: AppSizes.h(400),
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: ColorsManager.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: ColorsManager.primaryColor.withOpacity(0.85),
                  ),
                ),

                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => OnboardingIndicator(
                      index: index,
                      currentIndex: currentIndex,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                currentIndex < 2
                    ? Padding(
                        padding: EdgeInsets.only(bottom: AppSizes.h(60)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Spacer(),
                            OnboardingNavButton(
                              text: AppLocalizations.of(context).continueLabel,
                              onTap: onNext,
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: OnboardingNavButton(
                          text: AppLocalizations.of(context).startNow,
                          onTap: onSkip,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
