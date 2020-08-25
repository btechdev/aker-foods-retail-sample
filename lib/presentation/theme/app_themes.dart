import 'package:flutter/material.dart';

import '../../common/utils/pixel_dimension_util.dart';
import 'app_colors.dart';
import 'border_themes.dart';
import 'dialog_themes.dart';
import 'text_themes.dart';

class AppTheme {
  static ThemeData defaultTheme(BuildContext context) {
    PixelDimensionUtil.init(context);
    return ThemeData(
      primaryColor: AppColor.primaryColor,
      toggleableActiveColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.white,
      appBarTheme: const AppBarTheme(
        color: AppColor.transparent,
        elevation: 0.0,
      ),
      fontFamily: AppTextTheme.defaultFontFamily,
      textTheme: AppTextTheme.defaultTextTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: AppColor.primaryColor,
        shape: AppBorderTheme.primaryButtonBorder,
      ),
      dialogTheme: AppDialogTheme.defaultDialogTheme(),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColor.white,
        actionTextColor: AppColor.black,
        disabledActionTextColor: AppColor.grey,
        contentTextStyle: AppTextTheme.subhead,
        elevation: 0.0,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
