import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodia_chef/core/routes/routes.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  dynamic get({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> set({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    return await sharedPreferences.setDouble(key, value);
  }

  Future<bool> remove({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clear() async {
    return await sharedPreferences.clear();
  }

  bool containKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }
}

/// ✅ دالة تحديد أول Route عند تشغيل التطبيق
Future<String> getInitialRoute() async {
  final isFirstTime =
      SharedPref.sharedPreferences.getBool('isFirstTime') ?? true;
  final token = SharedPref.sharedPreferences.getString('token');

  if (isFirstTime) {
    await SharedPref.sharedPreferences.setBool('isFirstTime', false);
    return Routes.onboardingScreen;
  } else if (token != null && token.isNotEmpty) {
    return Routes.bottomNavBar;
  } else {
    return Routes.login;
  }
}
