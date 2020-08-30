import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/constants/route_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../common/extensions/string_extensions.dart';
import '../../common/utils/pixel_dimension_util.dart';
import '../../presentation/theme/app_colors.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  EnterPhoneNumberScreen({Key key}) : super(key: key);

  @override
  _EnterPhoneNumberScreen createState() => _EnterPhoneNumberScreen();
}

class _EnterPhoneNumberScreen extends State<EnterPhoneNumberScreen> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: KeyboardAvoider(
          autoScroll: true,
          child: _getBody(),
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

  Container _bodyLowerSectionContainer() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _phoneNumberInputHeaderContainer(),
            SizedBox(height: 12.h),
            _phoneNumberInputTextFieldContainer(),
            SizedBox(height: 8.h),
            _phoneNumberInputBottomText(),
            SizedBox(height: 24.h),
            _buttonWithContainer(),
          ],
        ),
      );

  Container _phoneNumberInputHeaderContainer() => Container(
        height: 48.h,
        alignment: Alignment.centerLeft,
        child: Text(
          'Let\'s get you started',
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Container _phoneNumberInputTextFieldContainer() => Container(
        alignment: Alignment.center,
        decoration: _phoneNumberInputBoxDecoration(),
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 8.h,
        ),
        height: 56.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _countryCodeText(),
            _divider(),
            Expanded(child: _phoneNumberInputTextField()),
          ],
        ),
      );

  BoxDecoration _phoneNumberInputBoxDecoration() => BoxDecoration(
        border: Border.all(color: AppColor.black25, width: 1.w),
        borderRadius: BorderRadius.circular(12.w),
      );

  Text _countryCodeText() => Text(
        '+91',
        style: Theme.of(context).textTheme.bodyText1,
      );

  Container _divider() => Container(
        color: AppColor.black25,
        width: 1.w,
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      );

  TextField _phoneNumberInputTextField() => TextField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        controller: _textEditingController,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Enter your phone number',
          hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                color: AppColor.black54,
              ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(AppConstants.phoneNumberLength),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.bodyText1,
      );

  Text _phoneNumberInputBottomText() => Text(
        'We will send you OTP on this number',
        style: Theme.of(context).textTheme.caption.copyWith(
              color: AppColor.grey,
            ),
      );

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        width: PixelDimensionUtil().uiWidthPx.toDouble(),
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: AppColor.grey,
          onPressed: _validateAndVerifyPhoneNumber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'Get OTP'.toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  void _validateAndVerifyPhoneNumber() {
    final phoneNumber = _textEditingController.text;
    if (phoneNumber.isNotNullAndEmpty &&
        phoneNumber.length == AppConstants.phoneNumberLength) {
      Navigator.pushNamed(
        context,
        RouteConstant.verifyOtp,
        arguments: phoneNumber,
      );
      return;
    }

    Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
      text: 'Please enter 10 digit valid phone number',
      type: CustomSnackBarType.error,
      position: CustomSnackBarPosition.top,
    ));

    /*
    // NOTE: This is sample code to show snack bar
    Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
      text: 'Testing the very very long snack bar text with success icon. '
          'Some more text to verify the behaviour.',
      type: CustomSnackBarType.success,
      position: CustomSnackBarPosition.top,
    ));
    */
  }
}
