import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_state.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../../common/utils/pixel_dimension_util.dart';
import '../../theme/app_colors.dart';
import '../../widgets/countdown_timer_text.dart';
import 'setup_user_profile_screen.dart';

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
  Animation<int> _animation;
  String _smsCode = '';
  bool showTimer = true;
  OTPTextField _otpTextField;
  final GlobalKey<OTPTextFieldState> _textfielKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _authBloc = Injector.resolve<FirebaseAuthBloc>();
//    setupOtpTextField();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    );

    _animation = StepTween(
      begin: 120,
      end: 0,
    ).animate(_controller)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            showTimer = false;
          });
        }
      });
    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupOtpTextField();
  }

  void setupOtpTextField() {
    _otpTextField = OTPTextField(
      key: _textfielKey,
      length: 6,
      fieldWidth: LayoutConstants.dimen_40.w,
      fieldStyle: FieldStyle.underline,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.bodyText1,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      onChanged: (String value) {
        setState(() {
          _smsCode = value;
        });
      },
      onCompleted: (String pin) {
        setState(
          () {
            _smsCode = pin;
          },
        );
      },
    );
  }

  void resetAnimation() {
    _controller.reset();
    _animation = StepTween(
      begin: 120,
      end: 0,
    ).animate(_controller);
    _controller.forward();
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
      debugPrint('AuthSuccessState');
      if (state.user.isNewUser) {
        debugPrint('New User');
        _navigateToSetupProfile();
      } else {
        debugPrint('Old User');
        _navigateToDashboard();
      }
    } else if (state is OtpVerificationSuccessState) {
      debugPrint('OtpVerificationSuccessState');
      if (state.user.isNewUser) {
        debugPrint('New User');
        _navigateToSetupProfile();
      } else {
        debugPrint('Old User');
        _navigateToDashboard();
      }
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
      debugPrint('$_authBloc');
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
                softWrap: true,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FlatButton(
              onPressed: () => _textfielKey.currentState.clearTextFields(),
              child: Text(
                'Clear OTP',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            )
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
              child: _otpTextField,
            ),
          ],
        ),
      );

  BlocBuilder _buttonWithContainer() =>
      BlocBuilder<FirebaseAuthBloc, FirebaseAuthState>(
        builder: (context, state) {
          if (state is OtpVerifyingState) {
            return Container(
              child: const CircularLoaderWidget(),
            );
          } else {
            return Container(
              height: LayoutConstants.dimen_48.h,
              width: PixelDimensionUtil().uiWidthPx.toDouble(),
              child: RaisedButton(
                color: AppColor.primaryColor,
                onPressed: _smsCode?.length == 6 ? _verifySmsOtp : null,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.dimen_12.w),
                ),
                child: Text(
                  'CONTINUE',
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ),
            );
          }
        },
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
                showTimer
                    ? CountdownTimerText(animation: _animation)
                    : IconButton(
                        onPressed: () {
                          _authBloc.add(
                              VerifyPhoneNumberEvent(phoneNumber: phoneNumber));
                          resetAnimation();
                          setState(() {
                            showTimer = true;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                      ),
              ],
            ),
            SizedBox(height: LayoutConstants.dimen_24.h),
            _buttonWithContainer()
          ],
        ),
      );

  void _verifySmsOtp() {
    _authBloc.add(AuthenticateWithSmsCodeEvent(
      phoneNumber: phoneNumber,
      smsCode: _smsCode,
    ));
  }

  String _showLastCharacters(String string, int count) =>
      string.length >= count ? string.substring(string.length - count) : '';

  void _navigateToSetupProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: true,
        fullscreenDialog: true,
        builder: (context) => SetupUserProfileScreen(),
      ),
    );
  }
}
