import 'dart:async';

import 'package:aker_foods_retail/common/constants/data_connection_constants.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

class DataConnectionUtil {
  final ValueNotifier<bool> notifier = ValueNotifier<bool>(null);
  DataConnectionChecker _checker = DataConnectionChecker();

  DataConnectionUtil() {
    _checker
      ..addresses = List.unmodifiable([
        AddressCheckOptions(
          DataConnectionConstants.pingAddress,
          port: DataConnectionConstants.pingAddressPort,
          timeout: DataConnectionConstants.pingTimeoutDuration,
        ),
      ])
      ..checkInterval = DataConnectionConstants.pingIntervalDuration
      ..onStatusChange.listen(_notifyStatus);
  }

  Completer<bool> _checking;

  void _notifyStatus(DataConnectionStatus status) {
    if (status == DataConnectionStatus.disconnected) {
      // Check connection after some time before notifying
      Future.delayed(DataConnectionConstants.pingIntervalRecheckDuration,
          () async {
        if (!(await isConnected)) {
          notifier.value = false;
        }
      });
    } else {
      notifier.value = true;
    }
  }

  Future<bool> get isConnected {
    if (_checking?.isCompleted != false) {
      _checking = Completer<bool>();
      _checker.hasConnection.then((value) {
        notifier.value = value;
        _checking.complete(value);
      });
    }
    return _checking.future;
  }

  void dispose() {
    _checker = null;
    notifier.dispose();
  }
}
