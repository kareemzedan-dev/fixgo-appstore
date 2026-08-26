import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("isDark") ?? false;

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = state == ThemeMode.dark;

    await prefs.setBool("isDark", !isDark);

    emit(!isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setLight() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", false);

    emit(ThemeMode.light);
  }

  Future<void> setDark() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", true);

    emit(ThemeMode.dark);
  }
}