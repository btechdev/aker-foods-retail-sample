import 'package:aker_foods_retail/common/utils/data_connection_util.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataConnectionBloc
    extends Bloc<DataConnectionEvent, DataConnectionState> {
  final DataConnectionUtil dataConnectionUtil;

  DataConnectionBloc({
    this.dataConnectionUtil,
  }) : super(DataConnectionState());

  @override
  Stream<DataConnectionState> mapEventToState(
      DataConnectionEvent event) async* {
    if (event is CheckDataConnectionEvent) {
      yield DataConnectionState(
        isConnected: await dataConnectionUtil.isConnected,
      );
    } else if (event is IndicateDataConnectionStatusEvent) {
      yield ShowDataConnectionSnackBarState(
        isConnected: await dataConnectionUtil.isConnected,
      );
    }
  }
}
