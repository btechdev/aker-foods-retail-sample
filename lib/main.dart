import 'dart:async';

import 'package:aker_foods_retail/common/utils/database_utils.dart';
import 'package:aker_foods_retail/config/app_update_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pedantic/pedantic.dart';

import '.env.dart' as secret_config;
import 'common/injector/injector.dart';
import 'common/injector/injector_config.dart';
import 'common/local_preferences/local_preferences.dart';
import 'config/configuration.dart';
import 'network/api/api_models_configuration.dart';
import 'presentation/app.dart';

Future<void> main() async {
  // Load configuration from secret environment
  Configuration().setConfigurationValues(secret_config.environment);

  InjectorConfig.setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  unawaited(DatabaseUtil.initDatabase());

  // Initialize shared preferences wrapper
  final localPreferences = Injector.resolve<LocalPreferences>();
  await localPreferences.init();

  final appUpdateConfig = Injector.resolve<AppUpdateConfig>();
  await appUpdateConfig.getAppUpdateInfo();
  final model = appUpdateConfig.getAppUpdateInfoFromLocal();
//  debugPrint('$model');

  // Enable Crashlytics based on environment and
  // Pass all uncaught errors from the framework to Crashlytics.
  /*
  Crashlytics.instance.enableInDevMode = Configuration.shouldEnableCrashlytics;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  */

  // Initialise OneSignal for push notification service
  unawaited(_initialiseOneSignal());

  // Set application for portrait device orientation
  unawaited(
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  );

  // Configure only to support Light mode. If Dark mode is needed, update this
  unawaited(FlutterStatusbarcolor.setStatusBarWhiteForeground(false));
  unawaited(FlutterStatusbarcolor.setStatusBarColor(Colors.transparent));

  unawaited(configureApiModels());

  runZoned(
    () => runApp(App(localPreferences)),
    //onError: Crashlytics.instance.recordError,
  );
}

Future<void> _initialiseOneSignal() async {
  await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // Keep this parameter to `true` if you want to adhere to GDPR privacy consent
  await OneSignal.shared.setRequiresUserPrivacyConsent(false);
  await OneSignal.shared.getPermissionSubscriptionState();

  final iOSSettings = {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false,
    OSiOSSettings.promptBeforeOpeningPushUrl: true
  };
  await OneSignal.shared.init(
    '15cc841b-f301-4663-a12e-9f5467eaf167',
    iOSSettings: iOSSettings,
  );

  await OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  // This function will show the iOS push notification prompt.
  // It is recommended removing the following code and instead using an
  // In-App Message to prompt for notification permission.
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);

  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    // a notification has been received
  });
}
