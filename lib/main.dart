import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pedantic/pedantic.dart';

import '.env.dart' as secret_config;
import 'common/injector/injector.dart';
import 'common/injector/injector_config.dart';
import 'common/local_preferences/local_preferences.dart';
import 'config/configuration.dart';
import 'presentation/app.dart';

void main() {
  InjectorConfig.setup();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // Initialize shared preferences wrapper
  unawaited(Injector.resolve<LocalPreferences>().init());

  // Load configuration from secret environment
  Configuration().setConfigurationValues(secret_config.environment);

  // Enable Crashlytics based on environment and
  // Pass all uncaught errors from the framework to Crashlytics.
  /*
  Crashlytics.instance.enableInDevMode = Configuration.shouldEnableCrashlytics;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  */

  // Only Light mode, need update if support darkmode
  unawaited(FlutterStatusbarcolor.setStatusBarWhiteForeground(false));
  unawaited(FlutterStatusbarcolor.setStatusBarColor(Colors.transparent));

  runZoned(
    () => runApp(App()),
    // TODO(Bhushan): Import crashlytics and uncomment this following code
    //onError: Crashlytics.instance.recordError,
  );
}
