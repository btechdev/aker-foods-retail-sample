import 'package:bloc/bloc.dart';

import 'snack_bar_event.dart';
import 'snack_bar_state.dart';

class SnackBarBloc extends Bloc<SnackBarEvent, SnackBarState> {
  SnackBarBloc() : super(SnackBarInitialState());

  @override
  Stream<SnackBarState> mapEventToState(SnackBarEvent event) async* {
    if (event is ShowSnackBarEvent) {
      yield SnackBarShownState(
        text: event.text,
        type: event.type,
        position: event.position,
      );
    }
  }
}
