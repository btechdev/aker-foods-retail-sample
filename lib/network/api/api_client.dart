import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';
import 'package:flutter/foundation.dart';

import '../http/http_client.dart';
import 'api_header_constants.dart';

class ApiClient extends HttpClient {
  ApiClient()
      : super(
          host: Configuration.host,
          header: getAuthorizationHeader(),
        );

  static Map<String, String> getAuthorizationHeader() => {
        HttpConstants.contentType: HttpConstants.jsonContentType,
        HttpConstants.authorization: '$firebaseTokenPrefix NO_TOKEN',
      };

  void updateAuthorizationHeader(String firebaseToken) {
    debugPrint('===== Updating AuthorizationHeader =====');
    header = {
      ...header,
      HttpConstants.authorization: '$firebaseTokenPrefix $firebaseToken',
    };
  }

  Map<String, String> getClientAuthenticationHeader() => header;
}
