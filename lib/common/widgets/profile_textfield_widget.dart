import 'package:flutter/material.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  final Icon prefixIcon;
  final String hintText;
  final Function onTextChange;
  final TextEditingController controller;

  ProfileTextFieldWidget({
    this.prefixIcon,
    this.hintText,
    this.onTextChange,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[500],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
