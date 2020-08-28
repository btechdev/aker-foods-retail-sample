import 'package:aker_foods_retail/presentation/my_account/widgets/my_account_screen.dart';
import 'package:aker_foods_retail/presentation/my_account/widgets/user_profile_screen.dart';
import 'package:flutter/material.dart';

import '../common/utils/pixel_dimension_util.dart';
import 'login/enter_otp_screen.dart';
import 'login/enter_phone_number_screen.dart';
import 'theme/app_themes.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorStateKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, widget) {
          PixelDimensionUtil.init(context, allowFontScaling: true);
          return _wrapWithThemedMaterialApp();
        },
      );

  MaterialApp _wrapWithThemedMaterialApp() => MaterialApp(
        navigatorKey: _navigatorStateKey,
        builder: (context, widget) {
          PixelDimensionUtil.init(
            context,
            allowFontScaling: true,
            navigator: _navigatorStateKey,
          );
          return widget;
        },
        title: 'Aker Foods Retail',
        theme: AppTheme.defaultTheme(),
        routes: {
          '/my-account': (context) => MyAccountScreen(),
          '/': (context) => EnterPhoneNumberScreen(
                title: 'Login',
              ),
          '/otp': (context) => EnterOtpScreen(),
          '/user-profile': (context) => UserProfileScreen(),
        },
        initialRoute: '/',
      );
}

/*class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorStateKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    PixelDimensionUtil.init(
      context,
      allowFontScaling: true,
      navigator: _navigatorStateKey,
    );
    return AppThemeUpdater(
      child: Builder(
        builder: (context) {
          PixelDimensionUtil.init(
            context,
            allowFontScaling: true,
            navigator: _navigatorStateKey,
          );
          return _materialApp();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context) {
        PixelDimensionUtil.init(
          context,
          allowFontScaling: true,
          navigator: _navigatorStateKey,
        );
        final abSp = 35.sp;
        print('=================== abSp: $abSp');
        return _materialApp();
      },
    );
  }

  MaterialApp _materialApp() {
    print('=================== Building Material App');
    return MaterialApp(
      navigatorKey: _navigatorStateKey,
      builder: (context, widget) {
        PixelDimensionUtil.init(
          context,
          allowFontScaling: true,
          navigator: _navigatorStateKey,
        );

        final h1 = Theme.of(context).textTheme.headline1.fontSize;
        final ah1 = Theme.of(context).textTheme.appHeadline1.fontSize;
        print('=================== Headline1: $h1');
        print('=================== App Headline1: $ah1');
        return widget;
      },
      title: 'Aker Foods Retail',
      theme: AppTheme.defaultTheme(),
      routes: {
        '/': (context) => EnterPhoneNumberScreen(
              title: 'Login',
            ),
        '/otp': (context) => EnterOTPScreen(),
      },
      initialRoute: '/',
    );
  }
}*/
