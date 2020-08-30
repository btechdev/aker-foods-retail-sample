import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/foundation.dart';

abstract class SnackBarState {
  final String text;
  final CustomSnackBarType type;
  final CustomSnackBarPosition position;

  SnackBarState({this.text, this.type, this.position});
}

class SnackBarInitialState extends SnackBarState {}

class SnackBarShownState extends SnackBarState {
  SnackBarShownState({
    @required String text,
    @required CustomSnackBarType type,
    CustomSnackBarPosition position,
  }) : super(
          text: text,
          type: type,
          position: position ?? CustomSnackBarPosition.top,
        );
}
