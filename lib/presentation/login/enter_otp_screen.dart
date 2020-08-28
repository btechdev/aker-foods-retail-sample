import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../common/utils/pixel_dimension_util.dart';
import '../../common/widgets/countdown_timer_text.dart';
import '../../presentation/login/setup_user_profile_screen.dart';
import '../../presentation/theme/app_colors.dart';

class EnterOtpScreen extends StatefulWidget {
  final String title;

  EnterOtpScreen({Key key, this.title}) : super(key: key);

  @override
  _EnterOTPScreen createState() => _EnterOTPScreen();
}

class _EnterOTPScreen extends State<EnterOtpScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardAvoider(
        autoScroll: true,
        child: _getBody(),
      ),
    );
  }

  Container _informationContainer() => Container(
        height: PixelDimensionUtil().uiHeightPx * 0.50,
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 32.h,
        ),
        child: Container(
          child: Image.asset('assets/images/logo_transparent_background.png'),
        ),
      );

  Container _getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            _informationContainer(),
            _bodyLowerSectionContainer(),
          ],
        ),
      );

  Container _otpInputHeaderContainer() => Container(
        height: 48.h,
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

  BoxDecoration _otpInputBoxDecoration() => BoxDecoration(
        border: Border.all(color: AppColor.black25, width: 1.w),
        borderRadius: BorderRadius.circular(12.w),
      );

  Container _otpInputTextFieldContainer() => Container(
        height: 56.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        decoration: _otpInputBoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: OTPTextField(
                length: 6,
                fieldWidth: 40.w,
                fieldStyle: FieldStyle.underline,
                width: PixelDimensionUtil().uiWidthPx * 0.80,
                style: Theme.of(context).textTheme.bodyText1,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                onCompleted: (pin) {},
              ),
            ),
          ],
        ),
      );

  Container _buttonWithContainer() => Container(
        height: 48.h,
        width: PixelDimensionUtil().uiWidthPx.toDouble(),
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetupUserProfileScreen(),
              fullscreenDialog: true,
              maintainState: true,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
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
            SizedBox(height: 12.h),
            _otpInputTextFieldContainer(),
            SizedBox(height: 8.h),
            Text(
              'OTP has been sent to **********',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.grey,
                  ),
            ),
            SizedBox(height: 8.h),
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
            SizedBox(height: 24.h),
            _buttonWithContainer()
          ],
        ),
      );
}
