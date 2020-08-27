import 'package:flutter/material.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import 'app_colors.dart';
import 'border_themes.dart';
import 'dialog_themes.dart';
import 'text_themes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData defaultTheme() => ThemeData(
        primaryColor: AppColor.primaryColor,
        toggleableActiveColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
        colorScheme: ColorScheme.light(
          primary: AppColor.primaryColor,
          onPrimary: AppColor.skyBlue,
          primaryVariant: AppColor.primaryColor.withOpacity(0.38),
          secondary: AppColor.primaryColorDark,
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: AppColor.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: AppColor.skyBlue,
            size: 24.w,
          ),
          actionsIconTheme: const IconThemeData(
            color: AppColor.skyBlue,
          ),
          textTheme: AppTextTheme.defaultTextTheme(),
        ),
        fontFamily: AppTextTheme.defaultFontFamily,
        primaryTextTheme: AppTextTheme.defaultTextTheme(),
        textTheme: AppTextTheme.defaultTextTheme(),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColor.primaryColor,
          shape: AppBorderTheme.primaryButtonBorder,
        ),
        dialogTheme: AppDialogTheme.defaultDialogTheme(),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColor.white,
          actionTextColor: AppColor.black,
          disabledActionTextColor: AppColor.grey,
          contentTextStyle: AppTextTheme.defaultTextTheme().subtitle1,
          elevation: 0.0,
          behavior: SnackBarBehavior.fixed,
        ),
      );
}
