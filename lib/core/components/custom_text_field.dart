import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE8E8E8),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText, // 👈 هنا
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: AppSizes.sp(12),
            fontWeight: FontWeight.w600,
            height: 1.60,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: AppSizes.sp(12),
              fontWeight: FontWeight.w400,
              height: 1.60,
              color: const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }
}
