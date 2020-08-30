import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/foundation.dart';

abstract class SnackBarEvent {}

class ShowSnackBarEvent extends SnackBarEvent {
  String text;
  CustomSnackBarType type;
  CustomSnackBarPosition position;

  ShowSnackBarEvent({
    @required this.text,
    @required this.type,
    this.position,
  });
}
