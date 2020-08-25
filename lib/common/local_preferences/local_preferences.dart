import 'package:shared_preferences/shared_preferences.dart';
import 'package:aker_foods_retail/common/constants/assertion_constants.dart';

export 'package:aker_foods_retail/common/constants/local_preferences_keys_constants.dart';

class LocalPreferences {
  SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> set(String key, dynamic value) {
    assert(
      value is bool || value is double || value is int || value is String,
      AssertionConstants.unsupportedType,
    );

    final Map<Type, Function> typeResolvers = {
      bool: sharedPreferences.setBool,
      double: sharedPreferences.setDouble,
      int: sharedPreferences.setInt,
      String: sharedPreferences.setString,
    };

    return typeResolvers[value.runtimeType](key, value);
  }

  dynamic get(String key) => sharedPreferences.get(key);

  Future<bool> remove(String key) => sharedPreferences.remove(key);
}
