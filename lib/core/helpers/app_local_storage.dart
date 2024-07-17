import 'package:hive_flutter/hive_flutter.dart';
import 'app_saved_key.dart';

class ApplocalStorage {
  static init() async {
    await Hive.initFlutter();
    await Hive.openBox(AppSavedKey.globalBox);
  }

  static final _box = Hive.box(AppSavedKey.globalBox);
  //! bool
  static Future clear() async {
    await _box.clear();
  }

  static Future saveBool(String key, bool value) async {
    await _box.put(key, value);
  }

  static bool getBool(String key) {
    var value = _box.get(key);
    if (value is bool) return value;
    return false;
  }

//! int
  static Future saveInt(String key, int value) async {
    await _box.put(key, value);
  }

  static int getInt(String key) {
    var value = _box.get(key);
    if (value is int) return value;
    return -1;
  }

//! string
  static Future saveString(String key, String value) async {
    await _box.put(key, value);
  }

  static String getString(String key) {
    var value = _box.get(key);
    if (value is String) return value;
    return '';
  }

  //! delete
  static Future<void> delete(String key) async {
    _box.delete(key);
  }

  static bool isAuthunticated() {
    var value = getString(AppSavedKey.token);
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  static String getToken() {
    return getString(AppSavedKey.token);
  }

  static String getUserId() {
    return getString(AppSavedKey.userId);
  }
  
  static String getAppLang() {
    return getString(AppSavedKey.appLang).isEmpty
        ? AppSavedKey.defaultLang
        : getString(AppSavedKey.appLang);
  }
}
