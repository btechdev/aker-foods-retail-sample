import 'package:aker_foods_retail/config/environment_enum.dart';
import 'package:flutter/foundation.dart';

class Configuration {
  static String _razorpayKey;

  static String _host;
  static String _environment;
  static bool _shouldEnableAllLogs;
  static bool _shouldEnableCrashlytics;

  void setConfigurationValues(Map<String, dynamic> value) {
    _host = value['host'];
    _razorpayKey = value['razorpayKey'];
    _environment = value['environment'] ?? describeEnum(Environment.dev);
    _shouldEnableAllLogs = value['shouldEnableAllLogs'] ?? true;
    _shouldEnableCrashlytics = value['shouldEnableCrashlytics'] ?? true;
  }

  static String get host => _host;

  static String get razorpayKey => _razorpayKey;

  static String get environment => _environment;

  static bool get shouldEnableAllLogs => _shouldEnableAllLogs;

  static bool get shouldEnableCrashlytics => _shouldEnableCrashlytics;

  static bool get isDev => _environment == describeEnum(Environment.dev);

  static bool get isProd => _environment == describeEnum(Environment.prod);
}
