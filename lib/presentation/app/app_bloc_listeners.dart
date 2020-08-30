import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_state.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocListener> getAppStartupBlocListeners(
  GlobalKey<NavigatorState> navigatorStateGlobalKey,
) =>
    [
      BlocListener<SnackBarBloc, SnackBarState>(
        listener: (context, state) =>
            _processSnackBarState(context, state, navigatorStateGlobalKey),
      ),
    ];

void _processSnackBarState(
  BuildContext context,
  SnackBarState state,
  GlobalKey<NavigatorState> navigatorStateGlobalKey,
) {
  if (state is SnackBarShownState) {
    CustomSnackBar(
      text: state.text,
      type: state.type,
      position: state.position,
    ).showWithNavigator(navigatorStateGlobalKey.currentState, context);
  }
}
