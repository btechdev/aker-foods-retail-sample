import 'package:flutter/material.dart';

import '../../common/constants/layout_constants.dart';
import '../../common/extensions/pixel_dimension_util_extensions.dart';
import '../theme/app_colors.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  final Icon prefixIcon;
  final String hintText;
  final TextStyle hintStyle;
  final Function onTextChange;
  final TextInputType textInputType;
  final TextEditingController controller;

  ProfileTextFieldWidget({
    this.prefixIcon,
    this.hintText,
    this.hintStyle,
    this.onTextChange,
    this.textInputType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        height: LayoutConstants.dimen_52.h,
        decoration: LayoutConstants.inputBoxDecoration,
        child: TextField(
          textAlign: TextAlign.start,
          keyboardType: textInputType ?? TextInputType.text,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: hintStyle ??
                Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppColor.black54,
                    ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      );
}
