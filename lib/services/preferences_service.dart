import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle all SharedPreferences operations
class PreferencesService {
  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception('PreferencesService not initialized. Call init() first.');
    }
    return _preferences!;
  }

  /// Check if it's the first time the app is launched
  static bool isFirstLaunch() {
    return preferences.getBool('first_time') ?? true;
  }

  /// Set first launch flag to false
  static Future<void> setFirstLaunchComplete() async {
    await preferences.setBool('first_time', false);
  }

  /// Clear all preferences (useful for logging out or testing)
  static Future<void> clearAll() async {
    await preferences.clear();
  }

  /// Check if the user is logged in
  static bool isLoggedIn() {
    return preferences.getBool('is_logged_in') ?? false;
  }

  /// Set login status to true when user logs in
  static Future<void> setLoggedIn() async {
    await preferences.setBool('is_logged_in', true);
  }

  /// Clear login status when user logs out
  static Future<void> logout() async {
    await preferences.setBool('is_logged_in', false);
  }

  /// Save user credentials (optional, be careful with security)
  static Future<void> saveUserEmail(String email) async {
    await preferences.setString('user_email', email);
  }

  /// Get saved user email
  static String? getUserEmail() {
    return preferences.getString('user_email');
  }
}
