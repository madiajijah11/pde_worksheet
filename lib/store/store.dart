import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> write(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static Future<String?> read(String key) async {
    return _prefs?.getString(key) ?? 'No data found';
  }

  static Future<void> delete(String key) async {
    await _prefs?.remove(key);
  }
}
