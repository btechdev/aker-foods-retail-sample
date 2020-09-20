import 'package:aker_foods_retail/data/models/society_model.dart';

import 'api_response_parser.dart';

Future<void> configureApiModels() async {
  ApiResponseParser.addParsingFunction(SocietyModel, SocietyModel.fromJson);
}
