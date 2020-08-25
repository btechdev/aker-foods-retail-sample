import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'border_themes.dart';
import 'text_themes.dart';

class AppDialogTheme {
  static double elevation = 0.0;

  static TextStyle titleTextStyle = AppTextTheme.subhead
      .copyWith(fontWeight: FontWeight.bold, color: AppColor.black);

  static TextStyle contentTextStyle =
      AppTextTheme.caption.copyWith(color: AppColor.black);

  static DialogTheme defaultDialogTheme() => DialogTheme(
        elevation: AppDialogTheme.elevation,
        shape: AppBorderTheme.dialogThemeShapeBorder,
        titleTextStyle: AppDialogTheme.titleTextStyle,
        contentTextStyle: AppDialogTheme.contentTextStyle,
      );
}
