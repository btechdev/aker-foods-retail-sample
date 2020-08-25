import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';

import '../http/http_client.dart';

class ApiClient extends HttpClient {
  ApiClient()
      : super(
          host: Configuration.host,
          header: getAuthenticationHeader(),
        );

  static Map<String, String> getAuthenticationHeader() {
    return {
      HttpConstants.authorization: Configuration.token,
      HttpConstants.contentType: HttpConstants.jsonContentType,
    };
  }

  void updateAuthenticationHeader(String accessToken) {
    header = {...header, 'Authorization': 'Bearer $accessToken'};
  }

  Map<String, String> getClientAuthenticationHeader() {
    return header;
  }
}
