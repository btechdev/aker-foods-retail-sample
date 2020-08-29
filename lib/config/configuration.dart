import 'package:flutter/foundation.dart';

import 'package:aker_foods_retail/config/default_env.dart';
import 'package:aker_foods_retail/config/environment_enum.dart';

class Configuration {
  static String _host = DefaultConfig.host;
  static String _token = DefaultConfig.token;
  static String _assetHost = DefaultConfig.assetHost;
  static String _environment = DefaultConfig.environment;
  static bool _shouldEnableAllLogs = DefaultConfig.shouldEnableAllLogs;
  static bool _shouldEnableCrashlytics = DefaultConfig.shouldEnableCrashlytics;

  void setConfigurationValues(Map<String, dynamic> value) {
    _host = value['host'] ?? DefaultConfig.host;
    _token = value['token'] ?? DefaultConfig.token;
    _assetHost = value['assetHost'] ?? DefaultConfig.assetHost;
    _environment = value['environment'] ?? DefaultConfig.environment;
    _shouldEnableAllLogs =
        value['shouldEnableAllLogs'] ?? DefaultConfig.shouldEnableAllLogs;
    _shouldEnableCrashlytics = value['shouldEnableCrashlytics'] ??
        DefaultConfig.shouldEnableCrashlytics;
  }

  static String get host => _host;

  static String get token => _token;

  static String get assetHost => _assetHost;

  static String get environment => _environment;

  static bool get shouldEnableAllLogs => _shouldEnableAllLogs;

  static bool get shouldEnableCrashlytics => _shouldEnableCrashlytics;

  static bool get isDev => _environment == describeEnum(Environment.dev);

  static bool get isProd => _environment == describeEnum(Environment.prod);
}
