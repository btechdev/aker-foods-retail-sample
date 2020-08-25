import 'dart:convert';
import 'package:http/http.dart';

import 'package:aker_foods_retail/network/http/http_constants.dart';

class HttpUtil {
  static dynamic encodeRequestBody(dynamic data, String contentType) {
    return contentType == HttpConstants.jsonContentType
        ? utf8.encode(json.encode(data))
        : data;
  }

  static dynamic getResponse(Response response) {
    return '';
  }

  static dynamic getFileResponse(Response response) {
    switch (response.statusCode) {
      case 201:
        return response;
      case 200:
        return response;
      default:
        getResponse(response);
    }
  }
}
