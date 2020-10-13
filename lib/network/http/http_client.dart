import 'dart:convert';
import 'dart:io' as dart_io;

import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/common/utils/data_connection_util.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';
import 'package:aker_foods_retail/network/http/http_method_enum.dart';
import 'package:aker_foods_retail/network/http/http_util.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_event.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

class HttpClient {
  IOClient _client;
  String host;
  Map<String, String> header;

  // ignore: close_sinks
  DataConnectionBloc dataConnectionBloc;
  DataConnectionUtil dataConnectionUtil;

  HttpClient({
    @required this.host,
    @required this.header,
    @required this.dataConnectionBloc,
    @required this.dataConnectionUtil,
  }) {
    final httpClient = dart_io.HttpClient()
      ..badCertificateCallback =
          (dart_io.X509Certificate cert, String host, int port) =>
              dart_io.Platform.isAndroid;
    _client = IOClient(httpClient);
  }

  Uri getParsedUrl(String path) {
    return Uri.parse('$host$path');
  }

  String parseDataAndSplitString(dynamic data) =>
      json.encode(data).splitLongStringForLogging();

  dynamic send(Request request) async {
    debugPrint(
      '====> Retrying HTTP request\n'
      'Method: ${request.method}\n'
      'Header: ${parseDataAndSplitString(request.headers)}\n'
      'Url: ${request.url.toString()}',
    );

    final IOStreamedResponse streamedResponse = await _client.send(request);
    return Response.fromStream(streamedResponse);
  }

  Future<bool> _isDataConnectionAvailable() async {
    final bool connected = await dataConnectionUtil.isConnected;
    if (!connected) {
      dataConnectionBloc.add(IndicateDataConnectionStatusEvent());
    }
    return connected;
  }

  dynamic get(
    String path, {
    Map<String, dynamic> overrideHeader = const {},
  }) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    final Map<String, String> requestHeader = {...header, ...overrideHeader};

    // TODO(Bhushan): Find a better way to log this data (eg. interceptor)
    debugPrint(
      'HTTP request\n'
      'Method: GET\n'
      'Header: ${parseDataAndSplitString(requestHeader)}\n'
      'Url: ${getParsedUrl(path)}',
    );

    final Response response = await _client.get(
      getParsedUrl(path),
      headers: requestHeader,
    );
    return HttpUtil.getResponse(response);
  }

  dynamic post(
    String path,
    dynamic data, {
    Map<String, dynamic> overrideHeader = const {},
  }) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    final Map<String, String> requestHeader = {...header, ...overrideHeader};
    final contentType = requestHeader[HttpConstants.contentType];

    String jsonBody;
    dynamic encodedBody;
    if (data == null) {
      jsonBody = '';
      encodedBody = '';
    } else {
      jsonBody = json.encode(data);
      encodedBody = HttpUtil.encodeRequestBody(data, contentType);
    }

    debugPrint(
      'HTTP request\n'
      'Method: POST\n'
      'Header: ${parseDataAndSplitString(requestHeader)}\n'
      'Url: ${getParsedUrl(path)}\n'
      'jsonBody: ${parseDataAndSplitString(jsonBody)}\n'
      'encodedBody: ${parseDataAndSplitString(encodedBody)}',
    );

    final response = await _client.post(
      getParsedUrl(path),
      body: encodedBody,
      headers: requestHeader,
    );

    try {
      final httpResponse = HttpUtil.getResponse(response);
      return httpResponse;
    } catch (error) {
      rethrow;
    }

    /*if (data == null) {
      debugPrint('HTTP request\n'
          'Method: POST\n'
          'Header: ${parseDataAndSplitString(requestHeader)}\n'
          'Url: ${getParsedUrl(path)}\n');

      final response = await _client.post(
        getParsedUrl(path),
        headers: requestHeader,
      );

      try {
        final httpResponse = HttpUtil.getResponse(response);
        return httpResponse;
      } catch (error) {
        rethrow;
      }
    } else {
      final jsonBody = json.encode(data);
      final encodedBody = HttpUtil.encodeRequestBody(data, contentType);

      debugPrint(
        'HTTP request\n'
        'Method: POST\n'
        'Header: ${parseDataAndSplitString(requestHeader)}\n'
        'Url: ${getParsedUrl(path)}\n'
        'jsonBody: ${parseDataAndSplitString(jsonBody)}\n'
        'encodedBody: ${parseDataAndSplitString(encodedBody)}',
      );

      final response = await _client.post(
        getParsedUrl(path),
        body: encodedBody,
        headers: requestHeader,
      );

      try {
        final httpResponse = HttpUtil.getResponse(response);
        return httpResponse;
      } catch (error) {
        rethrow;
      }
    }*/
  }

  dynamic patch(
    String path,
    dynamic data, {
    Map<String, dynamic> overrideHeader = const {},
  }) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    final Map<String, String> requestHeader = {...header, ...overrideHeader};

    debugPrint(
      'HTTP request\n'
      'Method: PATCH\n'
      'Header: ${parseDataAndSplitString(requestHeader)}\n'
      'Url: ${getParsedUrl(path)}\n'
      'Data: ${parseDataAndSplitString(data)}',
    );

    final Response response = await _client.patch(
      getParsedUrl(path),
      body: HttpUtil.encodeRequestBody(
          data, requestHeader[HttpConstants.contentType]),
      headers: requestHeader,
    );
    return HttpUtil.getResponse(response);
  }

  dynamic put(String path, dynamic data) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    debugPrint(
      'HTTP request\n'
      'Method: PUT\n'
      'Header: ${parseDataAndSplitString(header)}\n'
      'Url: ${getParsedUrl(path)}\n'
      'Data: ${parseDataAndSplitString(data)}',
    );

    final Response response = await _client.put(
      getParsedUrl(path),
      body: json.encode(data),
      headers: header,
    );
    return HttpUtil.getResponse(response);
  }

  dynamic delete(String path) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    debugPrint(
      'HTTP request\n'
      'Method: DELETE\n'
      'Header: ${parseDataAndSplitString(header)}\n'
      'Url: ${getParsedUrl(path)}\n',
    );

    final Response response = await _client.delete(
      getParsedUrl(path),
      headers: header,
    );
    return HttpUtil.getResponse(response);
  }

  dynamic uploadFile(
      String path, Map<String, dart_io.File> mapFile, Map<String, dynamic> data,
      [HttpMethodType method = HttpMethodType.post,
      Map<String, dynamic> overrideHeader]) async {
    if (!await _isDataConnectionAvailable()) {
      return;
    }

    final request = MultipartRequest(
        HttpMethod(type: method).toString(), getParsedUrl(path))
      ..headers['accept'] = 'application/json'
      ..headers[HttpConstants.contentType] =
          HttpConstants.multipartFormDataType;

    data?.forEach((key, value) => request.fields[key] = value);
    mapFile?.forEach((key, value) async {
      final mimeTypeData =
          lookupMimeType(value.path, headerBytes: [0xFF, 0xD8]).split('/');
      return request.files.add(
        await MultipartFile.fromPath(
          key,
          value.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    });

    final Response response = await Response.fromStream(await request.send());
    return HttpUtil.getResponse(response);
  }

  dynamic getResponse(Uri uri) async {
    if (!await _isDataConnectionAvailable()) {
      return Future.value(null);
    }
    final Response response = await _client.get(uri, headers: header);
    return json.decode(response.body);
  }
}
