import 'package:flutter/material.dart';

class AppSizes {
  static late MediaQueryData _mediaQuery;

  static late double screenWidth;
  static late double screenHeight;

  static late double scaleFactor;

  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);

    screenWidth = _mediaQuery.size.width;
    screenHeight = _mediaQuery.size.height;

    

    if (screenWidth < 600) {
      // Mobile
      scaleFactor = screenWidth / 390;
    } else if (screenWidth < 1100) {
      // Tablet
      scaleFactor = screenWidth / 700;
    } else {
      // Desktop/Web
      scaleFactor = screenWidth / 1440;
    }
  }

  // =========================
  // MAIN SCALE METHODS
  // =========================

  static double w(double size) {
    return size * scaleFactor;
  }

  static double h(double size) {
    return size * scaleFactor;
  }

  static double sp(double size) {
    return size * scaleFactor;
  }

  static double r(double size) {
    return size * scaleFactor;
  }

  // =========================
  // PADDINGS
  // =========================

  static double get p4 => w(4);
  static double get p6 => w(6);
  static double get p8 => w(8);
  static double get p10 => w(10);
  
  static double get p12 => w(12);
 static double get p14 => w(14);
  static double get p16 => w(16);
  static double get p18 => w(18);
  static double get p20 => w(20);
  static double get p24 => w(24);

  // =========================
  // FONT SIZES
  // =========================

  static double get sp10 => sp(10);
  static double get sp12 => sp(12);
  static double get sp14 => sp(14);
  static double get sp16 => sp(16);
  static double get sp18 => sp(18);
  static double get sp20 => sp(20);
  static double get sp24 => sp(24);

  // =========================
  // RADIUS
  // =========================

  static double get r8 => r(8);
  static double get r12 => r(12);
  static double get r16 => r(16);

  // =========================
  // HEIGHTS
  // =========================

  static double get h40 => h(40);
  static double get h48 => h(48);
  static double get h56 => h(56);

  // =========================
  // WIDTHS
  // =========================

  static double get w40 => w(40);
  static double get w48 => w(48);
  static double get w56 => w(56);

  // =========================
  // SCREEN HELPERS
  // =========================

  static bool get isMobile => screenWidth < 600;

  static bool get isTablet =>
      screenWidth >= 600 &&
      screenWidth < 1100;

  static bool get isDesktop =>
      screenWidth >= 1100;
}