import 'package:aker_foods_retail/common/widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  EnterPhoneNumberScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EnterPhoneNumberScreen createState() => _EnterPhoneNumberScreen();
}

class _EnterPhoneNumberScreen extends State<EnterPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30.0),
            height: size.height * 0.55,
            color: AppColor.backgroundScaffoldColor,
            child: Container(
              decoration: BoxDecoration(
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
              color: AppColor.backgroundScaffoldColor,
              height: size.height * .45,
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lets get you started',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
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
                    height: 50.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Container(
                          color: Colors.grey[500],
                          width: 1.0,
                          margin: EdgeInsets.all(5.0),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('We will send you OTP on this number'),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 45.0,
                    width: size.width,
                    child: RaisedButton(
                      color: AppColor.buttonBackgroundColor,
                      disabledColor: Colors.lightGreen,
                      onPressed: () => {Navigator.pushNamed(context, '/otp')},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'GET OTP',
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
