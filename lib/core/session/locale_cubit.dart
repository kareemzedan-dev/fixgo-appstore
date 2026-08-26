import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _prefsKey = 'app_locale';

  LocaleCubit() : super(const Locale('ar')) {
    loadLocale();
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);

    if (saved != null) {
      emit(Locale(saved));
      return;
    }

    // Default to Arabic if no saved preference
    emit(const Locale('ar'));
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
    emit(locale);
  }
}
