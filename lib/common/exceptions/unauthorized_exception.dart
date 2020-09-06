import 'package:aker_foods_retail/common/constants/exception_constants.dart';

import 'server_exception.dart';

class UnauthorisedException extends ServerException {
  UnauthorisedException(
    String error, {
    String url,
  }) : super(
          codeInt: ExceptionConstants.unauthorizedCode,
          codeString: ExceptionConstants.unauthorizedString,
          message: error,
        ) {
    // TODO(Bhushan): Implement logic to get automatically new access token
    //  for one time and re-execute the same request
  }
}
