import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// kv离线存储
class Storage {
  // 单例写法
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;
  late final SharedPreferencesAsync _prefs;

  Storage._internal();

  void init() {
    _prefs = SharedPreferencesAsync();
  }

  Future<void> setJson(String key, Object value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Future<void> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<void> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  Future<String> getString(String key) async {
    return await _prefs.getString(key) ?? '';
  }

  Future<bool> getBool(String key) async {
    return await _prefs.getBool(key) ?? false;
  }

  Future<List<String>> getList(String key) async {
    return await _prefs.getStringList(key) ?? [];
  }

  Future<void> remove(String key) async {
    return await _prefs.remove(key);
  }
}
