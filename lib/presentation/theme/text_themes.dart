import 'dart:ui';

import 'package:flutter/material.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import 'app_colors.dart';

class AppTextTheme {
  static final TextStyle display4 = TextStyle(
    fontSize: 38.sp,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle display3 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle display2 = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle display1 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle title = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle body2 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle body1 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle subhead = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle caption = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle button = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle subtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle overline = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.4,
  );

  static const String defaultFontFamily = 'MavenPro';

  static final TextTheme defaultTextTheme = TextTheme(
    display4: AppTextTheme.display4,
    display3: AppTextTheme.display3,
    display2: AppTextTheme.display2,
    display1: AppTextTheme.display1,
    headline: AppTextTheme.headline,
    title: AppTextTheme.title,
    subhead: AppTextTheme.subhead,
    body2: AppTextTheme.body2,
    body1: AppTextTheme.body1,
    caption: AppTextTheme.caption,
    button: AppTextTheme.button,
    subtitle: AppTextTheme.subtitle,
    overline: AppTextTheme.overline,
  );
}

extension AppTextThemeExtension on TextTheme {
  TextStyle get toastTitle => body2.copyWith(
        color: AppColor.black,
        height: 1.4,
      );

  TextStyle get toastSubTitle => subhead.copyWith(
        color: AppColor.black,
      );
}
