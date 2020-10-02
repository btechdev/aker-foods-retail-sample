import 'package:aker_foods_retail/common/exceptions/json_parsing_exception.dart';
import 'package:aker_foods_retail/network/api/api_response_parser.dart';

/*abstract class ApiDataModel<T> {
	// ignore: unused_element
	ApiDataModel._();

	ApiDataModel.fromJson(Map<String, dynamic> jsonMap);

	factory ApiDataModel.fromJson(Map<String, dynamic> jsonMap) {
		throw UnimplementedError('');
	}

	List<T> fromListJson(List<Map<String, dynamic>> jsonArrayMap);
}

mixin ApiDataModelMixin<T> implements ApiDataModel<T> {
  List<T> fromListJson(List<Map<String, dynamic>> jsonArrayMap);
}*/

class ApiResponse<T> {
  final int count;
  final String next;
  final String previous;
  final dynamic data;

  ApiResponse({
    this.count,
    this.next,
    this.previous,
    this.data,
  });

  // ignore: prefer_constructors_over_static_methods
  static ApiResponse fromJson<T>(Map<String, dynamic> jsonMap) {
    final int count = jsonMap['count'];
    final String next = jsonMap['next'];
    final String previous = jsonMap['previous'];
    dynamic data;
    if (jsonMap.containsKey('results')) {
      final List<dynamic> mapList = jsonMap['results'];
      data = ApiResponseParser.listFromJson<T>(mapList);
    } else if (jsonMap.containsKey('result')) {
      final Map<String, dynamic> map = jsonMap['result'];
      data = ApiResponseParser.objectFromJson<T>(map);
    } else {
      throw JsonParsingException(
        message: 'Json parsing for ${T.runtimeType} '
            'has failed as no payload with key '
            '\'results\' or \'result\' found',
      );
    }
    return ApiResponse(
      count: count,
      next: next,
      previous: previous,
      data: data,
    );
  }

  factory ApiResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    final int count = jsonMap['count'];
    final String next = jsonMap['next'];
    final String previous = jsonMap['previous'];
    dynamic data;
    if (jsonMap.containsKey('results')) {
      final List<dynamic> mapList = jsonMap['results'];
      data = ApiResponseParser.listFromJson<T>(mapList);
    } else if (jsonMap.containsKey('result')) {
      final Map<String, dynamic> map = jsonMap['result'];
      data = ApiResponseParser.objectFromJson<T>(map);
    } else {
      throw JsonParsingException(
        message: 'Json parsing for ${T.runtimeType} '
            'has failed as no payload with key '
            '\'results\' or \'result\' found',
      );
    }
    return ApiResponse(
      count: count,
      next: next,
      previous: previous,
      data: data,
    );
  }
}
