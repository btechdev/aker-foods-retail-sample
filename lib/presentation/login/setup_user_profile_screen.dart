import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../common/constants/layout_constants.dart';
import '../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../presentation/theme/app_colors.dart';
import '../widgets/profile_text_field_widget.dart';

class SetupUserProfileScreen extends StatefulWidget {
  @override
  _SetupProfileScreen createState() => _SetupProfileScreen();
}

class _SetupProfileScreen extends State<SetupUserProfileScreen> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: KeyboardAvoider(
        autoScroll: true,
        child: _getBody(),
      ),
    );
  }

  AppBar _getAppBar() => AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          'Profile Details',
          style: Theme.of(context).textTheme.button,
        ),
      );

  Container _getBody() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _salutationDropdownContainer(),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'First Name',
              prefixIcon: _textFieldPrefixIcon(Icons.assignment_ind),
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Last Name',
              prefixIcon: _textFieldPrefixIcon(Icons.assignment),
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Email',
              prefixIcon: _textFieldPrefixIcon(Icons.email),
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Referral Code (optional)',
              prefixIcon: _textFieldPrefixIcon(Icons.supervisor_account),
            ),
            SizedBox(height: 24.h),
            _buttonWithContainer(),
          ],
        ),
      );

  Icon _textFieldPrefixIcon(IconData data) => Icon(
        data,
        size: 30.w,
        color: AppColor.primaryColor,
      );

  SizedBox _inputFieldsVerticalSpacing() => SizedBox(height: 20.h);

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        width: double.infinity,
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: () => Navigator.pushNamed(context, '/my-account'),
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

  Container _salutationDropdownContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_52.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        decoration: LayoutConstants.inputBoxDecoration,
        child: Row(
          children: [
            _textFieldPrefixIcon(Icons.person),
            SizedBox(width: 8.w),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    hint: Text(
                      'Choose Title',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: AppColor.black54,
                          ),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24.w,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Mr', 'Mrs', 'Miss']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
