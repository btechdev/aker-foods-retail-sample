import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

Material wrapWithMaterialInkWell({
  @required BuildContext context,
  @required Widget child,
  Key cardKey,
  Color backgroundColor,
  Color highlightColor,
  ShapeBorder shapeBorder,
  BorderRadius borderRadius,
  GestureTapCallback onTap,
}) =>
    Material(
      key: cardKey,
      color: backgroundColor ?? AppColor.white,
      shape: shapeBorder,
      borderRadius: shapeBorder == null ? borderRadius : null,
      child: InkWell(
        highlightColor: highlightColor ?? Theme.of(context).highlightColor,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );

Material wrapWithMaterialInkWellCard({
  @required BuildContext context,
  @required Widget child,
  Key cardKey,
  Color cardColor,
  Color highlightColor,
  ShapeBorder shapeBorder,
  BorderRadius borderRadius,
  GestureTapCallback onTap,
}) =>
    Material(
      key: cardKey,
      type: MaterialType.card,
      color: cardColor ?? AppColor.white,
      shape: shapeBorder,
      borderRadius: shapeBorder == null ? borderRadius : null,
      child: InkWell(
        highlightColor: highlightColor ?? Theme.of(context).highlightColor,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );
