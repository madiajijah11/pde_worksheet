import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    if (_prefs == null) {
      try {
        _prefs = await SharedPreferences.getInstance();
      } catch (e) {
        debugPrint("Failed to initialize SharedPreferences: $e");
      }
    }
  }

  static Future<bool> write(String key, String value) async {
    await init();
    try {
      return await _prefs?.setString(key, value) ?? false;
    } catch (e) {
      debugPrint("Failed to write to SharedPreferences: $e");
      return false;
    }
  }

  static Future<String?> read(String key) async {
    await init();
    try {
      return _prefs?.getString(key);
    } catch (e) {
      debugPrint("Failed to read from SharedPreferences: $e");
      return null;
    }
  }

  static Future<bool> delete(String key) async {
    await init();
    try {
      return await _prefs?.remove(key) ?? false;
    } catch (e) {
      debugPrint("Failed to delete from SharedPreferences: $e");
      return false;
    }
  }
}
