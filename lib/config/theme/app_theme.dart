import 'package:flutter/material.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import '../../core/utils/colors_manager.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Alyamama',

    scaffoldBackgroundColor: ColorsManager.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.primaryColor,
      brightness: Brightness.light,
      primary: ColorsManager.primaryColor,
    ),

    /// AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.white,
      foregroundColor: ColorsManager.black,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: AppSizes.sp(18),
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
        fontFamily: 'Alyamama',
      ),
      iconTheme: IconThemeData(
        color: ColorsManager.black,
        size: AppSizes.sp(22),
      ),
    ),

    /// Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.white,
      selectedItemColor: ColorsManager.primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      showUnselectedLabels: true,
    ),

    /// Card
    cardTheme: CardThemeData(
      color: ColorsManager.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w(8),
        vertical: AppSizes.h(4),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(12)),
      ),
    ),

    /// Text Theme
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Alyamama',
        color: ColorsManager.black,
        fontSize: AppSizes.sp(16),
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Alyamama',
        color: ColorsManager.black.withValues(alpha: 0.8),
        fontSize: AppSizes.sp(14),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Alyamama',
        color: ColorsManager.black.withValues(alpha: 0.6),
        fontSize: AppSizes.sp(12),
      ),
      titleLarge: TextStyle(
        fontFamily: 'Alyamama',
        color: ColorsManager.black,
        fontSize: AppSizes.sp(18),
        fontWeight: FontWeight.w600,
      ),
    ),

    /// Input Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.white,

      contentPadding: EdgeInsets.symmetric(
        vertical: AppSizes.h(14),
        horizontal: AppSizes.w(16),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: ColorsManager.primaryColor, width: 1.5),
      ),

      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: AppSizes.sp(14),
      ),

      labelStyle: TextStyle(
        fontSize: AppSizes.sp(14),
        color: Colors.grey.shade600,
      ),

      floatingLabelStyle: TextStyle(
        fontSize: AppSizes.sp(14),
        color: ColorsManager.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),

    /// Icon Theme
    iconTheme: IconThemeData(color: ColorsManager.black, size: AppSizes.sp(22)),

    /// Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(4)),
      ),
      side: BorderSide(color: Colors.grey.shade400),
    ),

    /// Popup Menu Theme
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
      ),
      elevation: 4,
    ),

    /// Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: Colors.black,

        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.sp(14),
          fontFamily: 'Alyamama',
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(12)),
        ),

        padding: EdgeInsets.symmetric(
          vertical: AppSizes.h(14),
          horizontal: AppSizes.w(24),
        ),
      ),
    ),
  );

  /// ===============================
  /// DARK THEME
  /// ===============================

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Alyamama',

    scaffoldBackgroundColor: ColorsManager.black,

    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.primaryColor,
      brightness: Brightness.dark,
      primary: ColorsManager.primaryColor,
    ),

    /// AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.black,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: AppSizes.sp(18),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Alyamama',
      ),
      iconTheme: IconThemeData(color: Colors.white, size: AppSizes.sp(22)),
    ),

    /// Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0Xff1E1E1E),
      selectedItemColor: ColorsManager.white,

      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    /// Card
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C2C),
      elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w(8),
        vertical: AppSizes.h(4),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(12)),
      ),
    ),

    /// Text Theme
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Alyamama',
        color: Colors.white,
        fontSize: AppSizes.sp(16),
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Alyamama',
        color: Colors.white.withValues(alpha: 0.9),
        fontSize: AppSizes.sp(14),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Alyamama',
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: AppSizes.sp(12),
      ),
      titleLarge: TextStyle(
        fontFamily: 'Alyamama',
        color: Colors.white,
        fontSize: AppSizes.sp(18),
        fontWeight: FontWeight.w600,
      ),
    ),

    /// Input Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),

      contentPadding: EdgeInsets.symmetric(
        vertical: AppSizes.h(14),
        horizontal: AppSizes.w(16),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
        borderSide: BorderSide(color: ColorsManager.primaryColor, width: 1.5),
      ),

      hintStyle: TextStyle(
        color: Colors.grey.shade400,
        fontSize: AppSizes.sp(14),
      ),

      labelStyle: TextStyle(
        fontSize: AppSizes.sp(14),
        color: Colors.grey.shade400,
      ),

      floatingLabelStyle: TextStyle(
        fontSize: AppSizes.sp(14),
        color: ColorsManager.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),

    /// Icon Theme
    iconTheme: IconThemeData(color: Colors.white, size: AppSizes.sp(22)),

    /// Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(4)),
      ),
      side: BorderSide(color: Colors.grey.shade500),
    ),

    /// Popup Menu Theme
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r(14)),
      ),
      elevation: 4,
    ),

    /// Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: Colors.black,

        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.sp(14),
          fontFamily: 'Alyamama',
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(12)),
        ),

        padding: EdgeInsets.symmetric(
          vertical: AppSizes.h(14),
          horizontal: AppSizes.w(24),
        ),
      ),
    ),
  );
}
