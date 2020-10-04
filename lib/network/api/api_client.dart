import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/common/utils/data_connection_util.dart';
import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_bloc.dart';
import 'package:flutter/foundation.dart';

import '../http/http_client.dart';
import 'api_header_constants.dart';

class ApiClient extends HttpClient {
  final LocalPreferences localPreferences;

  ApiClient({
    @required this.localPreferences,
    @required DataConnectionBloc dataConnectionBloc,
    @required DataConnectionUtil dataConnectionUtil,
  }) : super(
          host: Configuration.host,
          header: {
            HttpConstants.contentType: HttpConstants.jsonContentType,
          },
          dataConnectionBloc: dataConnectionBloc,
          dataConnectionUtil: dataConnectionUtil,
        ) {
    final firebaseIdToken =
        localPreferences.get(PreferencesKeys.firebaseIdToken);
    updateAuthorizationHeader(firebaseIdToken);
  }

  void updateAuthorizationHeader(String firebaseToken) {
    debugPrint('===== Updating AuthorizationHeader =====');
    header = {
      ...header,
      HttpConstants.authorization: '$firebaseTokenPrefix $firebaseToken',
    };
  }

  Map<String, String> getClientAuthenticationHeader() => header;
}
