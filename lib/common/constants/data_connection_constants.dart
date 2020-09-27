import 'dart:io';

class DataConnectionConstants {
  static const pingTimeoutDuration = Duration(seconds: 5);
  static const pingIntervalDuration = Duration(seconds: 10);
  static const pingIntervalRecheckDuration = Duration(seconds: 2);

  static const pingAddressPort = 53;
  static InternetAddress pingAddress = InternetAddress('8.8.4.4');
}
