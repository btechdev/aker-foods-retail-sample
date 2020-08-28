import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'border_themes.dart';
import 'text_themes.dart';

class AppDialogTheme {
  static double elevation = 0.0;

  static TextStyle titleTextStyle = AppTextTheme.defaultTextTheme().subtitle1;

  static TextStyle contentTextStyle = AppTextTheme.defaultTextTheme().bodyText2;

  static DialogTheme defaultDialogTheme() => DialogTheme(
        elevation: AppDialogTheme.elevation,
        shape: AppBorderTheme.dialogThemeShapeBorder,
        titleTextStyle: AppDialogTheme.titleTextStyle,
        contentTextStyle: AppDialogTheme.contentTextStyle,
      );
}
