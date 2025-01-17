import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static const String token = "token";

  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);
  static bool getBool(String key) => _prefs!.getBool(key) ?? false;

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);
  static String getString(String key) => _prefs!.getString(key) ?? "";
  static List<Map<String, dynamic>> getList(String key) {
    List<String>? jsonStringList = _prefs?.getStringList(key);
    if (jsonStringList == null) {
      return [];
    } else {
      List<Map<String, dynamic>> decodedList = jsonStringList
          .map((jsonString) => json.decode(jsonString) as Map<String, dynamic>)
          .toList();
      return decodedList;
    }
  }

  // Example of a method to save a list of maps as a list of JSON strings
  static Future<bool> setList(String key, List<Map<String, dynamic>> value) {
    List<String> jsonStringList =
        value.map((item) => json.encode(item)).toList();
    return _prefs!.setStringList(key, jsonStringList);
  }

  static Future<bool> remove(String key) async => await _prefs!.remove(key);
}
