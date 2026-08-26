//==========================
// 8. service_details_area_chip.dart
//==========================
import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class ServiceDetailsAreaChip extends StatelessWidget {
  final String title;
  const ServiceDetailsAreaChip({Key? key, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.h(14),
        vertical: AppSizes.p8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(AppSizes.r(12)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.sp(13),
          color: ColorsManager.darkGrey,
        ),
      ),
    );
  }
}
