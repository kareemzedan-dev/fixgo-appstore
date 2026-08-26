import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';

class AppTextStyles {
  static TextStyle bold32 = TextStyle(
    fontSize: AppSizes.sp(32),
    fontWeight: FontWeight.w800,
  );

  static TextStyle bold24 = TextStyle(
    fontSize: AppSizes.sp(24),
    fontWeight: FontWeight.w700,
  );

  static TextStyle bold20 = TextStyle(
    fontSize: AppSizes.sp(20),
    fontWeight: FontWeight.w700,
  );

  static TextStyle bold16 = TextStyle(
    fontSize: AppSizes.sp(16),
    fontWeight: FontWeight.w700,
  );

  static TextStyle bold14 = TextStyle(
    fontSize: AppSizes.sp(14),
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle regular16 = TextStyle(
    fontSize: AppSizes.sp(16),
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular14 = TextStyle(
    fontSize: AppSizes.sp(14),
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular12 = TextStyle(
    fontSize: AppSizes.sp(12),
    fontWeight: FontWeight.w400,
  );

  static TextStyle semiBold16White = semiBold18.copyWith(
    fontSize: AppSizes.sp(16),
  );

  static TextStyle bold24Primary = bold24.copyWith(
    fontSize: AppSizes.sp(24),
    fontWeight: FontWeight.w700,
  );
}
