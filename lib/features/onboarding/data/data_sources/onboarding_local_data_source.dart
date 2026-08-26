import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class OnboardingLocalDataSource {
  static const String onboardingKey = 'hasFinishedOnboarding';

  Future<bool> hasFinishedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  Future<void> setFinishedOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, value);
  }
}
