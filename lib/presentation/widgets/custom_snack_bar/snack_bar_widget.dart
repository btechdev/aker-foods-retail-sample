import 'dart:async';
import 'dart:ui';

import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'snack_bar_constants.dart';
import 'snack_bar_route.dart';

typedef OnSnackBarStatusChanged = void Function(CustomSnackBarStatus status);

const String customSnackBarRoute = '/custom-snack-bar';

// ignore: must_be_immutable
class CustomSnackBar<T extends Object> extends StatefulWidget {
  final BuildContext context;
  final String text;
  final CustomSnackBarType type;
  final CustomSnackBarPosition position;
  OnSnackBarStatusChanged onStatusChanged;

  CustomSnackBar({
    Key key,
    this.context,
    this.text,
    this.type = CustomSnackBarType.success,
    this.position = CustomSnackBarPosition.top,
  }) : super(key: key) {
    onStatusChanged = onStatusChanged ?? (status) {};
  }

  int duration = customSnackBarDefaultTimeDurationInSeconds;

  SnackBarRoute<T> _customSnackBarRoute;

  Future<T> show(BuildContext context) async {
    _customSnackBarRoute =
        showSnackBar<T>(context: context, customSnackBar: this);
    return Navigator.of(context, rootNavigator: false)
        .push(_customSnackBarRoute);
  }

  Future<T> showWithNavigator(
      NavigatorState navigator, BuildContext context) async {
    _customSnackBarRoute =
        showSnackBar<T>(context: context, customSnackBar: this);
    return navigator.push(_customSnackBarRoute);
  }

  Future<T> dismiss([T result]) async {
    if (_customSnackBarRoute == null) {
      return null;
    }
    return null;
  }

  /// Checks if the custom snack bar is visible
  bool isShowing() =>
      _customSnackBarRoute?.currentStatus == CustomSnackBarStatus.showing;

  /// Checks if the custom snack bar is dismissed
  bool isDismissed() =>
      _customSnackBarRoute?.currentStatus == CustomSnackBarStatus.dismissed;

  @override
  State createState() => _TopSnackBarState<T>();
}

class _TopSnackBarState<K extends Object> extends State<CustomSnackBar>
    with TickerProviderStateMixin {
  GlobalKey backgroundBoxKey = GlobalKey();
  CustomSnackBarStatus currentStatus;

  FocusScopeNode _focusScopeNode;
  FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _focusAttachment.detach();
    super.dispose();
  }

  Icon _snackBarIcon() => Icon(
        widget.type == CustomSnackBarType.success
            ? Icons.beenhere
            : Icons.error,
        color: widget.type == CustomSnackBarType.success
            ? AppColor.primaryColor
            : AppColor.cautionColor,
        size: LayoutConstants.dimen_32.w,
      );

  Text _snackBarText() => Text(
        widget.text ?? '',
        softWrap: true,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColor.black54,
              fontWeight: FontWeight.w500,
            ),
      );

  List<Widget> _snackbarRow() {
    return <Widget>[
      ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: LayoutConstants.dimen_40.w,
        ),
        child: _snackBarIcon(),
      ),
      Flexible(
        child: Padding(
          padding: EdgeInsets.only(
            left: LayoutConstants.dimen_8.w,
            right: LayoutConstants.dimen_8.w,
          ),
          child: _snackBarText(),
        ),
      ),
    ];
  }

  BoxDecoration boxDecoration = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(LayoutConstants.dimen_24.w),
    boxShadow: [
      BoxShadow(
        color: AppColor.black25,
        blurRadius: LayoutConstants.dimen_8.w,
        offset: const Offset(0.5, 0.5),
      )
    ],
  );

  Widget _buildSnackBarContent() => Container(
        key: backgroundBoxKey,
        decoration: boxDecoration,
        margin: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w,
          right: LayoutConstants.dimen_16.w,
          top: LayoutConstants.dimen_8.h,
          bottom: LayoutConstants.dimen_8.h,
        ),
        child: Row(
          children: _snackbarRow(),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        alignment: _snackBarContentAlignment(),
        margin: _snackBarContainerMargin(),
        child: Material(
          type: MaterialType.transparency,
          child: _buildSnackBarContent(),
        ),
      );

  Alignment _snackBarContentAlignment() =>
      widget.position == CustomSnackBarPosition.top
          ? Alignment.topCenter
          : Alignment.bottomCenter;

  EdgeInsets _snackBarContainerMargin() =>
      widget.position == CustomSnackBarPosition.top
          ? EdgeInsets.only(top: LayoutConstants.dimen_60.h)
          : EdgeInsets.only(bottom: LayoutConstants.dimen_60.h);
}
