import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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

  // Initialise OneSignal for push notification service
  _initialiseOneSignal();

  // Configure only to support Light mode. If Dark mode is needed, update this
  unawaited(FlutterStatusbarcolor.setStatusBarWhiteForeground(false));
  unawaited(FlutterStatusbarcolor.setStatusBarColor(Colors.transparent));

  runZoned(
    () => runApp(App()),
    // TODO(Bhushan): Import crashlytics and uncomment this following code
    //onError: Crashlytics.instance.recordError,
  );
}

void _initialiseOneSignal() {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // Keep this parameter to `true` if you want to adhere to GDPR privacy consent
  OneSignal.shared.setRequiresUserPrivacyConsent(false);

  final iOSSettings = {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false,
    OSiOSSettings.promptBeforeOpeningPushUrl: true
  };
  OneSignal.shared.init(
    '15cc841b-f301-4663-a12e-9f5467eaf167',
    iOSSettings: iOSSettings,
  );

  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  // This function will show the iOS push notification prompt.
  // It is recommended removing the following code and instead using an
  // In-App Message to prompt for notification permission.
  OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
}

/*Future<void> _initialiseOneSignal() async {
  await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.verbose);

  // Keep this parameter to `true` if you want to adhere to GDPR privacy consent
  await OneSignal.shared.setRequiresUserPrivacyConsent(true);

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

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
}*/
