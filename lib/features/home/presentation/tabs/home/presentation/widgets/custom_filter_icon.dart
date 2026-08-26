import 'package:flutter/material.dart';

class CustomFilterIcon extends StatelessWidget {
  final VoidCallback onTap;
  final double size;      // حجم الكونتينر
  final double iconSize;  // حجم الأيقونة

  const CustomFilterIcon({
    super.key,
    required this.onTap,
    this.size = 24,      // 👈 أصغر من 30
    this.iconSize = 16,  // 👈 أصغر من 22
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFF160B48),
          borderRadius: BorderRadius.circular(size / 2.2), // تناسب تلقائي
        ),
        child: Center(
          child: Transform.rotate(
            angle: 1.5708, // 90°
            child: Icon(
              Icons.tune,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}