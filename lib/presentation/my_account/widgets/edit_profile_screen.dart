import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:aker_foods_retail/common/widgets/profile_text_field_widget.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: KeyboardAvoider(
        child: _getBody(size),
      ),
    );
  }

  Container _getBody(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: size.width - 32.0,
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[500],
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColor.primaryColor,
                  size: 30.0,
                ),
                const SizedBox(width: 10.0),
                _getTitleContainer(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ProfileTextFieldWidget(
            hintText: 'First Name',
            prefixIcon: _textFieldPrefixIcon(Icons.person),
          ),
          const SizedBox(height: 20),
          ProfileTextFieldWidget(
            hintText: 'Last Name',
            prefixIcon: _textFieldPrefixIcon(Icons.person),
          ),
          const SizedBox(height: 20),
          ProfileTextFieldWidget(
            hintText: 'Email',
            prefixIcon: _textFieldPrefixIcon(Icons.email),
          ),
          const SizedBox(height: 20),
          ProfileTextFieldWidget(
            hintText: 'Phone Number',
            prefixIcon: _textFieldPrefixIcon(Icons.phone_android),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          Container(
            height: 45.0,
            width: size.width,
            child: RaisedButton(
              color: AppColor.primaryColor,
              disabledColor: Colors.lightGreen,
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _getTitleContainer() {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: _getDropdown(),
      ),
    );
  }

  DropdownButtonHideUnderline _getDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        hint: const Text(
          'Choose Title',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
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
    );
  }

  Icon _textFieldPrefixIcon(IconData data) => Icon(
        data,
        size: 30.0,
        color: AppColor.primaryColor,
      );
}
