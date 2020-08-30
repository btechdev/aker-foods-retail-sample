import 'package:flutter/material.dart';

import '../common/constants/route_constants.dart';
import '../common/utils/pixel_dimension_util.dart';
import 'location/choose_your_location/choose_your_location_screen.dart';
import 'login/enter_otp_screen.dart';
import 'login/enter_phone_number_screen.dart';
import 'theme/app_themes.dart';
import 'user/edit_profile/edit_profile_screen.dart';
import 'user/my_account/my_account_screen.dart';

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
          RouteConstant.initial: (context) => EnterPhoneNumberScreen(),
          RouteConstant.verifyOtp: (context) => EnterOtpScreen(),
          RouteConstant.myAccount: (context) => MyAccountScreen(),
          RouteConstant.editProfile: (context) => EditProfileScreen(),
          RouteConstant.chooseLocation: (context) => ChooseYourLocationScreen(),
        },
        initialRoute: RouteConstant.initial,
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
