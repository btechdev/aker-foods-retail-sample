import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:aker_foods_retail/common/widgets/app_color.dart';
import 'package:aker_foods_retail/presentation/login/setup_profile_screen.dart';
import 'package:aker_foods_retail/common/widgets/countdown_timer.dart';

class EnterOTPScreen extends StatefulWidget {
  EnterOTPScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EnterOTPScreen createState() => _EnterOTPScreen();
}

class _EnterOTPScreen extends State<EnterOTPScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(minutes: 5))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 30.0),
            height: size.height * 0.60,
            color: AppColor.backgroundScaffoldColor,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.onboardingPageContainerColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(130.0),
                  bottomRight: Radius.circular(200.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: size.height * .40,
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              color: AppColor.backgroundScaffoldColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => {Navigator.pop(context)}),
                        Expanded(
                          child: const Text(
                            'Enter 6 digit OTP',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.all(5.0),
                    height: 40.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: OTPTextField(
                            length: 6,
                            width: 200,
                            fieldWidth: 40,
                            style: TextStyle(fontSize: 14),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('OTP has been sent to 9804159491'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Have not received your OTP yet?'),
                      Countdown(
                        animation: StepTween(
                          begin: 5 * 60,
                          end: 0,
                        ).animate(_controller),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    height: 45.0,
                    width: size.width,
                    child: RaisedButton(
                      color: AppColor.buttonBackgroundColor,
                      disabledColor: Colors.lightGreen,
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetupProfileScreen(),
                              fullscreenDialog: true,
                              maintainState: true),
                        ),
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
