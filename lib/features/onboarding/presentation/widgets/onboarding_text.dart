import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class OnboardingText extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingText({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.sp(14),
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
