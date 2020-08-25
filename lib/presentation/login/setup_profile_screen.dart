import 'package:aker_foods_retail/common/widgets/app_color.dart';
import 'package:aker_foods_retail/common/widgets/profile_textfield_widget.dart';
import 'package:flutter/material.dart';

class SetupProfileScreen extends StatefulWidget {
  @override
  _SetupProfileScreen createState() => _SetupProfileScreen();
}

class _SetupProfileScreen extends State<SetupProfileScreen> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
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
                  Icon(
                    Icons.person,
                    color: AppColor.textfieldPrefixIconColor,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          hint: Text(
                            'Choose Title',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          icon: Icon(Icons.arrow_drop_down),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileTextFieldWidget(
              hintText: 'First Name',
              prefixIcon: Icon(
                Icons.person,
                size: 30.0,
                color: AppColor.textfieldPrefixIconColor,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileTextFieldWidget(
              hintText: 'Last Name',
              prefixIcon: Icon(
                Icons.person,
                size: 30.0,
                color: AppColor.textfieldPrefixIconColor,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileTextFieldWidget(
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                size: 30.0,
                color: AppColor.textfieldPrefixIconColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.30,
            ),
            Container(
              height: 45.0,
              width: size.width,
              child: RaisedButton(
                color: AppColor.buttonBackgroundColor,
                disabledColor: Colors.lightGreen,
                onPressed: () => {},
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
    );
  }
}
