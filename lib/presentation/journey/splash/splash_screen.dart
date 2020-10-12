import 'dart:io';

import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/common/utils/data_connection_util.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/config/app_update_config.dart';
import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/data/models/force_update_data_model.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

const androidPlayStoreUrl = 'https://play.google.com/store';
const iosAppStoreUrl = 'https://www.apple.com/app-store/';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  String url = '';
  final localPreferences = Injector.resolve<LocalPreferences>();

  @override
  void initState() {
    super.initState();
    _checkDataConnectionAndAppUpdate();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Image.asset(
            'assets/images/splash_image.png',
            width: PixelDimensionUtil.screenWidth,
            height: PixelDimensionUtil.screenHeight,
            fit: BoxFit.contain,
          ),
          Positioned(
            top: LayoutConstants.dimen_76.h,
            left:
                PixelDimensionUtil.screenWidth / 2 - LayoutConstants.dimen_16.w,
            child: _isLoading
                ? SizedBox(
                    height: LayoutConstants.dimen_32.h,
                    width: LayoutConstants.dimen_32.w,
                    child: const CircularLoaderWidget(),
                  )
                : Container(),
          )
        ],
      );

  Future<void> _checkDataConnectionAndAppUpdate() async {
    final isInternetConnectionAvailable =
        await Injector.resolve<DataConnectionUtil>().isConnected;
    if (isInternetConnectionAvailable ?? false) {
      await _getAppUpdateStatus();
    } else {
      await _showExitAppDialog();
    }
  }

  Future<void> _getAppUpdateStatus() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    /*String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String buildNumber = packageInfo.buildNumber;*/

    try {
      final appUpdateConfig = Injector.resolve<AppUpdateConfig>();
      final forceUpdateData =
          await appUpdateConfig.getForceUpdateData(currentVersion);
      setState(() {
        _isLoading = false;
      });
      if (forceUpdateData?.isMandatory ?? false) {
        await _showForceUpdateDialog(forceUpdateData);
      } else {
        await _redirectToNextScreen();
      }
    } catch (_) {
      await _redirectToNextScreen();
    }
  }

  RaisedButton _updateButton(ForceUpdateDataModel forceUpdateData) =>
      RaisedButton(
        onPressed: () => _launchURL(forceUpdateData.appUrl),
        child: Text(
          'Update',
          style: Theme.of(context).textTheme.button.copyWith(
                color: AppColor.white,
              ),
        ),
      );

  FlatButton _laterButton() => FlatButton(
        onPressed: () {
          Navigator.pop(context);
          _redirectToNextScreen();
        },
        child: Text(
          'Later',
          style: Theme.of(context).textTheme.button.copyWith(
                color: AppColor.grey,
              ),
        ),
      );

  Future<void> _showForceUpdateDialog(
      ForceUpdateDataModel forceUpdateData) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text(
          'Mandatory App Update!',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        content: Text(
          'A new app version is available since '
          '${forceUpdateData.releasedDate}. '
          'Please update your app for further use.',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        actions: [
          if (Configuration.isDev) _laterButton(),
          _updateButton(forceUpdateData),
        ],
      ),
    );
  }

  Future<void> _redirectToNextScreen() async {
    await Navigator.of(context).pushNamedAndRemoveUntil(
      appInitialRoute,
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _launchURL(String urlString) async {
    final defaultUrl = Platform.isIOS ? iosAppStoreUrl : androidPlayStoreUrl;
    final url = urlString ?? defaultUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'Unable to redirect you to applications\' store',
      ));
      await _redirectToNextScreen();
    }
  }

  Future<void> _showExitAppDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text(
          'No Internet Connection',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        content: Text(
          'It seems that you are not connected to internet. '
          'Please retry again after enabling internet on your device.',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        actions: [_exitAppButton()],
      ),
    );
  }

  FlatButton _exitAppButton() => FlatButton(
        onPressed: () {
          Navigator.pop(context);
          SystemNavigator.pop();
        },
        child: Text(
          'OK',
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.grey,
              ),
        ),
      );

  String get appInitialRoute {
    final String idToken =
        localPreferences.get(PreferencesKeys.firebaseIdToken);
    if (idToken.isNullOrEmpty) {
      return RouteConstants.enterPhoneNumber;
    }

    final bool userHasSetupProfile =
        localPreferences.get(PreferencesKeys.userHasSetupProfile);
    if (!userHasSetupProfile) {
      return RouteConstants.setupUserProfile;
    }

    return RouteConstants.dashboard;
  }
}
