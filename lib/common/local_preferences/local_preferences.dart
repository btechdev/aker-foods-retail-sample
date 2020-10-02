import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/assertion_constants.dart';

export 'package:aker_foods_retail/common/constants/local_preferences_keys_constants.dart';

class LocalPreferences {
  SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> set(String key, dynamic value) {
    if (key == null || value == null) {
      return Future.value(false);
    }

    assert(
      value is bool || value is double || value is int || value is String,
      AssertionConstants.unsupportedType,
    );

    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
      // ignore: avoid_double_and_int_checks
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else {
      return sharedPreferences.setString(key, value);
    }
  }

  dynamic get(String key) => sharedPreferences.get(key);

  Future<bool> remove(String key) => sharedPreferences.remove(key);

  Future<bool> clear() => sharedPreferences.clear();
}
