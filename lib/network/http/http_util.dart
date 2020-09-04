import 'dart:convert';

import 'package:aker_foods_retail/common/exceptions/bad_request_exception.dart';
import 'package:aker_foods_retail/common/exceptions/forbidden_exception.dart';
import 'package:aker_foods_retail/common/exceptions/not_found_exception.dart';
import 'package:aker_foods_retail/common/exceptions/server_error_exception.dart';
import 'package:aker_foods_retail/common/exceptions/unauthorized_exception.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HttpUtil {
  static const unknownError = 'UNKNOWN_ERROR';

  static dynamic encodeRequestBody(dynamic data, String contentType) {
    return contentType == HttpConstants.jsonContentType
        ? utf8.encode(json.encode(data))
        : data;
  }

  static dynamic getResponse(Response response) {
    debugPrint(
      'HTTP response\n'
      'Status: ${response.statusCode}\n'
      'Request: ${response.request}\n'
      'Data: ${response.body.splitLongStringForLogging()}',
    );

    switch (response.statusCode) {
      case 200:
        return _getSuccessResponse(response);
      case 201:
        return _getSuccessResponse(response);
      case 204:
        return null;

      case 302:
        return response;

      case 400:
        throw BadRequestException(
          getErrorMessage(json.decode(response.body)),
        );

      case 401:
        throw UnauthorisedException(
          getErrorMessage(json.decode(response.body)),
          url: response.request.url.toString(),
        );

      case 403:
        throw ForbiddenException(
          getErrorMessage(json.decode(response.body)),
        );

      case 404:
        throw NotFoundException(
          getErrorMessage(json.decode(response.body)),
        );

      case 500:
      default:
        throw ServerErrorException(
          getErrorMessage(json.decode(response.body)),
        );
    }
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

  static dynamic _getSuccessResponse(Response response) {
    final Map<String, dynamic> _responseJson = json.decode(response.body);
    return _responseJson;
  }

  static String getErrorMessage(dynamic result) {
    if (result['error'] is String) {
      return result;
    } else if (result['error'] != null && result['error']['message'] != null) {
      return result['error']['message'];
    }
    return unknownError;
  }
}
