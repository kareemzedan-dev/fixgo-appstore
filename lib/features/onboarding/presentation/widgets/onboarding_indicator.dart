import 'package:flutter/material.dart';
import '../../../../../core/utils/colors_manager.dart';

class OnboardingIndicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const OnboardingIndicator({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 10 : 10,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? ColorsManager.primaryColor : ColorsManager.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
