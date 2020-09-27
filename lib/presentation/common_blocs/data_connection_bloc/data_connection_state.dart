class DataConnectionState {
  final bool isConnected;

  DataConnectionState({
    this.isConnected = false,
  });
}

class ShowDataConnectionSnackBarState extends DataConnectionState {
  ShowDataConnectionSnackBarState({
    bool isConnected,
  }) : super(
          isConnected: isConnected,
        );
}
