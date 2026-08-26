/// core/session/session_local_data_source.dart
library;

import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/models/user_model.dart';
@singleton
class SessionLocalDataSource {
  static const String userKey = "current_user";

  /// Save current logged in user
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      userKey,
      jsonEncode(user.toMap()),
    );
  }

  /// Get current logged in user
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(userKey);

    if (jsonString == null) return null;

    return UserModel.fromMap(
      jsonDecode(jsonString),
    );
  }

  /// Remove current user (logout)
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(userKey);
  }

  /// Check login status
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(userKey);
  }
}