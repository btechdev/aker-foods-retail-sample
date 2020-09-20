class ApiResponseParser {
  static Map<Type, dynamic Function(Map<String, dynamic>)>
      objectParsingFunctionsMap = Map();

  static void addParsingFunction(
      Type type, dynamic Function(Map<String, dynamic>) function) {
    objectParsingFunctionsMap[type] = function;
  }

  static List<T> listFromJson<T>(List<dynamic> mapList) {
    final mappingFunction = objectParsingFunctionsMap[T];
    if (mappingFunction == null) {
      throw UnimplementedError(
        'Json parsing for ${T.runtimeType} has not been defined',
      );
    }
    return mapList
        .map((dynamicMap) {
          final Map<String, dynamic> jsonMap = dynamicMap;
          return mappingFunction.call(jsonMap);
        })
        .cast<T>()
        .toList();
  }

  static T objectFromJson<T>(Map<String, dynamic> map) {
    final mappingFunction = objectParsingFunctionsMap[T];
    if (mappingFunction == null) {
      throw UnimplementedError(
        'Json parsing for ${T.runtimeType} has not been defined',
      );
    }
    return mappingFunction.call(map);
  }
}
