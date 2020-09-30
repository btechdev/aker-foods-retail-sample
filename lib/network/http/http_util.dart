import 'dart:convert';

import 'package:aker_foods_retail/common/exceptions/bad_request_exception.dart';
import 'package:aker_foods_retail/common/exceptions/forbidden_exception.dart';
import 'package:aker_foods_retail/common/exceptions/not_found_exception.dart';
import 'package:aker_foods_retail/common/exceptions/product_out_of_stock_exception.dart';
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
  static const unknownError = 'UNKNOWN_ERROR';

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
        return _retryRequestAfterRefreshAuthorization(response);

      case 403:
        throw ForbiddenException(
          getErrorMessage(json.decode(response.body)),
        );

      case 404:
        throw NotFoundException(
          getErrorMessage(json.decode(response.body)),
        );
      case 406:
        throw ProductOutOfStockException(
          //getErrorMessage(json.decode(response.body)),
          'There is no error message from server for out of stock products',
          outOfStockProductIds:
              _getOutOfStockProductIds(json.decode(response.body)),
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

  static Set<String> _getOutOfStockProductIds(dynamic errorBody) {
    final Map<String, dynamic> outOfStockProductsMap =
        errorBody['item_unstocked'];
    if (outOfStockProductsMap != null) {
      return outOfStockProductsMap.keys.toSet();
    }
    return Set();
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
