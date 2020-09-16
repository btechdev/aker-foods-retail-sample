import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LayoutConstants {
  LayoutConstants._();

  static const appBarDefaultElevation = dimen_8;
  static const cardDefaultElevation = dimen_4;

  static double get primaryButtonHeight => dimen_48.h;

  static BorderRadius get defaultBorderRadius =>
      BorderRadius.circular(dimen_12.w);

  static BoxDecoration get inputBoxDecoration => BoxDecoration(
        border: Border.all(color: AppColor.black25, width: dimen_1.w),
        borderRadius: defaultBorderRadius,
      );

  static RoundedRectangleBorder get borderlessRoundedRectangle =>
      RoundedRectangleBorder(borderRadius: defaultBorderRadius);

  static const padding = 18.0;
  static const fontHeight = 1.5;
  static const safeAreaBottom = 34.0;
  static const heightInputSearch = 34.0;
  static const standardPadding = 16.0;
  static const widthWord = 6.0;
  static const layoutContactCard = 160.0;
  static const paddingZero = 0.0;
  static const defaultHeightBtn = 50.0;

  static const dimen_0 = 0.0;
  static const dimen_1 = 1.0;
  static const dimen_2 = 2.0;
  static const dimen_3 = 3.0;
  static const dimen_4 = 4.0;
  static const dimen_5 = 5.0;
  static const dimen_6 = 6.0;
  static const dimen_8 = 8.0;
  static const dimen_10 = 10.0;

  static const dimen_12 = 12.0;
  static const dimen_16 = 16.0;
  static const dimen_20 = 20.0;
  static const dimen_24 = 24.0;
  static const dimen_28 = 28.0;
  static const dimen_30 = 30.0;
  static const dimen_32 = 32.0;
  static const dimen_36 = 36.0;
  static const dimen_40 = 40.0;
  static const dimen_44 = 44.0;
  static const dimen_48 = 48.0;
  static const dimen_52 = 52.0;
  static const dimen_56 = 56.0;
  static const dimen_60 = 60.0;

  static const dimen_64 = 64.0;
  static const dimen_68 = 68.0;
  static const dimen_70 = 70.0;
  static const dimen_76 = 76.0;
  static const dimen_80 = 80.0;
  static const dimen_90 = 90.0;
  static const dimen_100 = 100.0;

  static const dimen_120 = 120.0;
  static const dimen_130 = 130.0;
  static const dimen_140 = 140.0;
  static const dimen_150 = 150.0;
  static const dimen_160 = 160.0;
  static const dimen_170 = 170.0;
  static const dimen_180 = 180.0;
  static const dimen_190 = 190.0;
  static const dimen_200 = 200.0;
}
