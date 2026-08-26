import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class VerificationFeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const VerificationFeatureItem({
    super.key,
    required this.title,
    this.icon = Icons.checklist_rtl_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2D6CDF), size: 22),
        SizedBox(width: AppSizes.w(12)),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppSizes.sp(12),
              fontFamily: 'Alyamama',
              fontWeight: FontWeight.w600,
              height: 1.60,
            ),
          ),
        ),
      ],
    );
  }
}
