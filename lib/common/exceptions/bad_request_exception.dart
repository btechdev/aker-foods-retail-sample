import 'package:aker_foods_retail/common/constants/exception_constants.dart';

import 'server_exception.dart';

class BadRequestException extends ServerException {
  /*BadRequestException(Map<String, dynamic> error)
      : super(
          codeInt:
              error['codeInt'] ?? ExceptionConstants.internalServerErrorCode,
          codeString:
              error['code'] ?? ExceptionConstants.internalServerErrorString,
          message: error['message'] ?? '',
        );*/

  BadRequestException(String error)
      : super(
          codeInt: ExceptionConstants.badRequestCode,
          codeString: ExceptionConstants.badRequestString,
          message: error,
        );
}
