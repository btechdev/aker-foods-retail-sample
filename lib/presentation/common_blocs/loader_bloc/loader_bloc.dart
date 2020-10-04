import 'package:flutter_bloc/flutter_bloc.dart';

import 'loader_event.dart';
import 'loader_state.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(Dismissed());

  @override
  Stream<LoaderState> mapEventToState(LoaderEvent event) async* {
    switch (event.runtimeType) {
      case ShowLoaderEvent:
        yield* _loading(event);
        break;
      case DismissLoaderEvent:
        yield Dismissed();
        break;
    }
  }

  Stream<LoaderState> _loading(ShowLoaderEvent event) async* {
    yield Loading(isTopLoading: event.isTopLoader);
  }
}
