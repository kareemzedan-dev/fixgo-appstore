import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = const Color(0xFF243E63),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      // أفضل من h54
      height: AppSizes.h(54),

      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,

          disabledBackgroundColor: backgroundColor,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r(20)),
          ),
        ),

        child: isLoading
            ? SizedBox(
                height: AppSizes.w(22),
                width: AppSizes.w(22),

                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Text(
                text,

                style: TextStyle(
                  color: textColor,

                  // أفضل من sp12 الثابت
                  fontSize: AppSizes.sp(14),

                  fontFamily: 'Alyamama',

                  fontWeight: FontWeight.w600,

                  height: 1.4,
                ),
              ),
      ),
    );
  }
}
