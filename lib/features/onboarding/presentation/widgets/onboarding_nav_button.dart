import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/colors_manager.dart';

class OnboardingNavButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const OnboardingNavButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 300,
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: ColorsManager.white),
          ),
        ),
      ),
    );
  }
}
