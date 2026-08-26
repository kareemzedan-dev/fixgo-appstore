import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: AppSizes.w(48),
        height: AppSizes.h(48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Icon(Icons.arrow_back_ios_new_outlined, size: AppSizes.w(18)),
      ),
    );
  }
}
