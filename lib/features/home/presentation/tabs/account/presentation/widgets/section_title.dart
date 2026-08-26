import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.sp(16),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
