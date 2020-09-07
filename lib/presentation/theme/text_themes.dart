import 'dart:ui';

import 'package:flutter/material.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import 'app_colors.dart';

class AppTextTheme {
  static const String defaultFontFamily = 'MavenPro';

  static final TextStyle headline1 = TextStyle(
    fontSize: 60.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline2 = TextStyle(
    fontSize: 48.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline3 = TextStyle(
    fontSize: 36.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline4 = TextStyle(
    fontSize: 32.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline5 = TextStyle(
    fontSize: 24.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle headline6 = TextStyle(
    fontSize: 20.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle subtitle1 = TextStyle(
    fontSize: 16.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle subtitle2 = TextStyle(
    fontSize: 14.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle bodyText1 = TextStyle(
    fontSize: 18.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle bodyText2 = TextStyle(
    fontSize: 16.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle button = TextStyle(
    fontSize: 20.sp,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static final TextStyle caption = TextStyle(
    fontSize: 15.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.4,
  );

  static final TextStyle overline = TextStyle(
    fontSize: 12.sp,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.5,
  );

  /*static const TextStyle _headline1 = TextStyle(
    fontSize: 60,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _headline2 = TextStyle(
    fontSize: 48,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _headline3 = TextStyle(
    fontSize: 36,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _headline4 = TextStyle(
    fontSize: 32,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _headline5 = TextStyle(
    fontSize: 24,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _headline6 = TextStyle(
    fontSize: 20,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _subtitle1 = TextStyle(
    fontSize: 16,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _subtitle2 = TextStyle(
    fontSize: 14,
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _bodyText1 = TextStyle(
    fontSize: 18,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _bodyText2 = TextStyle(
    fontSize: 16,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _button = TextStyle(
    fontSize: 20,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle _caption = TextStyle(
    fontSize: 15,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.4,
  );

  static const TextStyle _overline = TextStyle(
    fontSize: 12,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 1.5,
  );

  static TextTheme defaultTextTheme() {
  return const TextTheme(
      headline1: _headline1,
      headline2: _headline2,
      headline3: _headline3,
      headline4: _headline4,
      headline5: _headline5,
      headline6: _headline6,
      subtitle1: _subtitle1,
      subtitle2: _subtitle2,
      bodyText1: _bodyText1,
      bodyText2: _bodyText2,
      caption: _caption,
      button: _button,
      overline: _overline,
    );
  }*/

  static TextTheme defaultTextTheme() => TextTheme(
        headline1: AppTextTheme.headline1,
        headline2: AppTextTheme.headline2,
        headline3: AppTextTheme.headline3,
        headline4: AppTextTheme.headline4,
        headline5: AppTextTheme.headline5,
        headline6: AppTextTheme.headline6,
        subtitle1: AppTextTheme.subtitle1,
        subtitle2: AppTextTheme.subtitle2,
        bodyText1: AppTextTheme.bodyText1,
        bodyText2: AppTextTheme.bodyText2,
        caption: AppTextTheme.caption,
        button: AppTextTheme.button,
        overline: AppTextTheme.overline,
      );
}

extension AppTextThemeExtension on TextTheme {
  /*TextStyle get appHeadline1 => headline1.copyWith(
        fontSize: headline1.fontSize.sp,
      );

  TextStyle get appHeadline2 => headline2.copyWith(
        fontSize: headline2.fontSize.sp,
      );

  TextStyle get appHeadline3 => headline3.copyWith(
        fontSize: headline3.fontSize.sp,
      );

  TextStyle get appHeadline4 => headline4.copyWith(
        fontSize: headline4.fontSize.sp,
      );

  TextStyle get appHeadline5 => headline5.copyWith(
        fontSize: headline5.fontSize.sp,
      );

  TextStyle get appHeadline6 => headline6.copyWith(
        fontSize: headline6.fontSize.sp,
      );

  TextStyle get appSubtitle1 => subtitle1.copyWith(
        fontSize: subtitle1.fontSize.sp,
      );

  TextStyle get appSubtitle2 => subtitle2.copyWith(
        fontSize: subtitle2.fontSize.sp,
      );

  TextStyle get appBodyText1 => bodyText1.copyWith(
        fontSize: bodyText1.fontSize.sp,
      );

  TextStyle get appBodyText2 => bodyText2.copyWith(
        fontSize: bodyText2.fontSize.sp,
      );

  TextStyle get appButton => button.copyWith(
        fontSize: button.fontSize.sp,
      );

  TextStyle get appCaption => caption.copyWith(
        fontSize: caption.fontSize.sp,
      );

  TextStyle get appOverline => overline.copyWith(
        fontSize: overline.fontSize.sp,
      );*/

  TextStyle get toastTitle => subtitle2.copyWith(
        height: 1.2,
      );

  TextStyle get toastSubtitle => bodyText2;
}
