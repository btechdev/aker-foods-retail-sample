import 'dart:convert';

import 'package:aker_foods_retail/common/constants/json_keys_constants.dart';
import 'package:aker_foods_retail/common/exceptions/bad_request_exception.dart';
import 'package:aker_foods_retail/common/exceptions/cart_data_exception.dart';
import 'package:aker_foods_retail/common/exceptions/forbidden_exception.dart';
import 'package:aker_foods_retail/common/exceptions/not_found_exception.dart';
import 'package:aker_foods_retail/common/exceptions/server_error_exception.dart';
import 'package:aker_foods_retail/common/exceptions/unauthorized_exception.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/firebase_auth_utils.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_header_constants.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HttpUtil {
  static const unknownError = 'Unknown error occurred.\n'
      'Please contact support team.';

  static bool _hasAttemptedRefreshAuthorization = false;
  static Response _apiRequestResponse;

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
      case HttpConstants.success:
      case HttpConstants.createSuccess:
        return _getSuccessResponse(response);

      case HttpConstants.redirect:
        return response;

      case HttpConstants.badRequest:
        throw BadRequestException(
          getErrorMessage(json.decode(response.body)),
        );

      case HttpConstants.unauthorized:
        return _retryRequestAfterRefreshAuthorization(response);

      case HttpConstants.forbidden:
        throw ForbiddenException(
          getErrorMessage(json.decode(response.body)),
        );

      case HttpConstants.notFound:
        throw NotFoundException(
          getErrorMessage(json.decode(response.body)),
        );

      case HttpConstants.cartDataException:
        throw CartDataException.fromJson(json.decode(response.body));

      case HttpConstants.serverError:
      default:
        throw ServerErrorException(
          getErrorMessage(json.decode(response.body)),
        );
    }
  }

  static dynamic getFileResponse(Response response) {
    switch (response.statusCode) {
      case HttpConstants.success:
      case HttpConstants.createSuccess:
        return response;

      default:
        getResponse(response);
    }
  }

  static dynamic _getSuccessResponse(Response response) {
    final Map<String, dynamic> _responseJson = json.decode(response.body);
    _responseJson[JsonKeysConstants.responseStatusCode] = response.statusCode;
    return _responseJson;
  }

  static String getErrorMessage(dynamic result) {
    if (result['error'] is String) {
      return result['error'];
    } else if (result['message'] is String) {
      return result['message'];
    } else if (result['error'] != null && result['error']['message'] != null) {
      return result['error']['message'];
    }
    return unknownError;
  }

  static dynamic _retryRequestAfterRefreshAuthorization(
      Response response) async {
    if (_hasAttemptedRefreshAuthorization) {
      _hasAttemptedRefreshAuthorization = false;
      throw UnauthorisedException(
        getErrorMessage(json.decode(_apiRequestResponse.body)),
        url: _apiRequestResponse?.request?.url?.toString(),
      );
    }

    _apiRequestResponse = response;
    final Request request = response.request;

    final String newIdToken = await _refreshIdTokenAndUpdateDependencies();
    return _executeNewRequestWithUpdatedApiClient(request, newIdToken);
  }

  static Future<String> _refreshIdTokenAndUpdateDependencies() async {
    final firebaseAuthUtils = Injector.resolve<FirebaseAuthUtils>();
    final String newIdToken =
        await firebaseAuthUtils.refreshFirebaseIdTokenAndUpdate();
    debugPrint('=====> Firebase IdToken Refreshed =====>'
        '\nNew Token: $newIdToken');
    return newIdToken;
  }

  static dynamic _executeNewRequestWithUpdatedApiClient(
      Request request, String newIdToken) async {
    try {
      /// NOTE: New request needs to be created as the `request` is already
      /// finalized and `send()` can not finalize the already finalized request.
      final Request newRequest = Request(request.method, request.url);
      newRequest.headers[HttpConstants.authorization] =
          '$firebaseTokenPrefix $newIdToken';
      newRequest
        ..encoding = request.encoding
        ..body = request.body
        ..bodyBytes = request.bodyBytes
        ..followRedirects = request.followRedirects
        ..maxRedirects = request.maxRedirects
        ..persistentConnection = request.persistentConnection;

      // TODO(Bhushan): Handle body fields for content-type =>
      //  "application/x-www-form-urlencoded"

      final apiClient = Injector.resolve<ApiClient>();
      final Response newResponse = await apiClient.send(newRequest);
      return getResponse(newResponse);
    } catch (e) {
      debugPrint('NewRequest caught ==> $e');
      debugPrint('NewRequest caught string ==> ${e?.toString()}');
      rethrow;
    }
  }
}
