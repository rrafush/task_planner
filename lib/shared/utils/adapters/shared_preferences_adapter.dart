import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesAdapter {
  Future<List<Map<String, dynamic>>> getData();
  Future<void> setData(String key, Map<String, dynamic> data);
  Future<void> removeData(String key);
  Future<void> clearData();
}

class SharedPreferencesAdapterImpl implements SharedPreferencesAdapter {
  @override
  Future<List<Map<String, dynamic>>> getData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final keys = sharedPreferences.getKeys().toList();
    final data = <Map<String, dynamic>>[];
    for (var key in keys) {
      final value = sharedPreferences.getString(key);
      if (value != null) {
        data.add(jsonDecode(value));
      }
    }

    return data;
  }

  @override
  Future<void> setData(String key, Map<String, dynamic> data) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(data));
  }

  @override
  Future<void> removeData(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> clearData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
