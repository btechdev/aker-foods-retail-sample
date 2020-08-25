import 'dart:convert';
import 'dart:io';

/// Creates the environment specific file .env.dart
/// All values maintained in config.json
/// Environment variables if specified will be replaced at build time in CI
///
/// Usage:  dart tools/env.dart
Future<void> main() async {
  //read a config.json file with all app related entries.
  //Any new app related constant is added to config.json
  final Map<String, dynamic> config = {};
  final String env = Platform.environment['environment'] ?? 'dev';
  final file = File('tools/config.json');
  final String content = file.readAsStringSync();
  final Map<String, dynamic> appConfig = json.decode(content);
  config['environment'] = env;

  //read the keys for system level environment variables from env variables.
  appConfig['environmentVariables'].forEach(
      (key, value) => config[key] = Platform.environment[key] ?? value);

  //appconstants:
  appConfig[env].forEach((key, value) => config[key] = value);

  const filename = 'lib/.env.dart';

  await File(filename).writeAsString(
      'final Map<String, dynamic> environment = ${json.encode(config)};');
}
