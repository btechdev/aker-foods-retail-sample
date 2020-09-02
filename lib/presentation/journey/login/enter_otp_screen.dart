import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../../common/utils/pixel_dimension_util.dart';
import '../../theme/app_colors.dart';
import '../../widgets/countdown_timer_text.dart';

class EnterOtpScreen extends StatefulWidget {
  EnterOtpScreen({Key key}) : super(key: key);

  @override
  _EnterOTPScreen createState() => _EnterOTPScreen();
}

class _EnterOTPScreen extends State<EnterOtpScreen>
    with SingleTickerProviderStateMixin {
  String phoneNumber;

  bool _firstTime = true;
  FirebaseAuthBloc _authBloc;
  AnimationController _controller;
  String _smsCode = '';

  @override
  void initState() {
    super.initState();
    _authBloc = Injector.resolve<FirebaseAuthBloc>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _authenticationStateListener(
    BuildContext context,
    FirebaseAuthState state,
  ) {
    if (state is AuthSuccessState) {
      final user = state.user;
      debugPrint('user id - $user');
      _navigateToDashboard();
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetupUserProfileScreen(),
            fullscreenDialog: true,
            maintainState: true),
      );*/
    } else if (state is OtpVerificationSuccessState) {
      _navigateToDashboard();
    } else {
      debugPrint('Error');
    }
  }

  void _navigateToDashboard() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteConstants.dashboard,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_firstTime) {
      phoneNumber = ModalRoute.of(context).settings.arguments;
      debugPrint('EnterOtpScreen building with => $phoneNumber');
      _authBloc.add(VerifyPhoneNumberEvent(phoneNumber: phoneNumber));
      _firstTime = false;
    }

    return BlocProvider<FirebaseAuthBloc>(
      create: (context) => _authBloc,
      child: Scaffold(
        body: KeyboardAvoider(
          autoScroll: true,
          child: BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
            listener: _authenticationStateListener,
            child: _getBody(),
          ),
        ),
      ),
    );
  }

  Container _informationContainer() => Container(
        height: PixelDimensionUtil().uiHeightPx * 0.50,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_32.w,
          vertical: LayoutConstants.dimen_32.h,
        ),
        child: Container(
          child: Image.asset('assets/images/logo_transparent_background.png'),
        ),
      );

  Container _getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        child: Column(
          children: [
            _informationContainer(),
            _bodyLowerSectionContainer(),
          ],
        ),
      );

  Container _otpInputHeaderContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Text(
                'Enter 6 digit OTP',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      );

  Container _otpInputTextFieldContainer() => Container(
        height: LayoutConstants.dimen_40.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_12.w),
        child: Row(
          children: [
            Expanded(
              child: OTPTextField(
                length: 6,
                fieldWidth: LayoutConstants.dimen_40.w,
                fieldStyle: FieldStyle.underline,
                keyboardType: TextInputType.number,
                //width: PixelDimensionUtil().uiWidthPx * 0.80,
                style: Theme.of(context).textTheme.bodyText1,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                onCompleted: (pin) {
                  setState(() {
                    _smsCode = pin;
                  });
                },
              ),
            ),
          ],
        ),
      );

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        width: PixelDimensionUtil().uiWidthPx.toDouble(),
        child: RaisedButton(
          color: AppColor.primaryColor,
          onPressed: _smsCode?.length == 6 ? _verifySmsOtp : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'CONTINUE',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  Container _bodyLowerSectionContainer() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _otpInputHeaderContainer(),
            SizedBox(height: LayoutConstants.dimen_12.h),
            _otpInputTextFieldContainer(),
            SizedBox(height: LayoutConstants.dimen_20.h),
            Text(
              'OTP has been sent to'
              '+91 *******${_showLastCharacters(phoneNumber, 3)}',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.grey,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Have not received your OTP yet?',
                  style: Theme.of(context).textTheme.caption,
                ),
                CountdownTimerText(
                  animation:
                      StepTween(begin: 2 * 60, end: 0).animate(_controller),
                ),
              ],
            ),
            SizedBox(height: LayoutConstants.dimen_24.h),
            _buttonWithContainer()
          ],
        ),
      );

  void _verifySmsOtp() {
    if (Configuration.isDev) {
      _navigateToDashboard();
    } else {
      _authBloc.add(AuthenticateWithSmsCodeEvent(
        phoneNumber: phoneNumber,
        smsCode: _smsCode,
      ));
    }
  }

  String _showLastCharacters(String string, int count) =>
      string.length >= count ? string.substring(string.length - count) : '';
}
