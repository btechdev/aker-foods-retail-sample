import 'package:aker_foods_retail/common/constants/exception_constants.dart';

import 'server_exception.dart';

class ProductOutOfStockException extends ServerException {
  final Set<String> outOfStockProductIds;

  ProductOutOfStockException(
    String errorMessage, {
    this.outOfStockProductIds,
  }) : super(
          codeInt: ExceptionConstants.productOutOfStockCode,
          codeString: ExceptionConstants.productOutOfStockString,
          message: errorMessage,
        );
}
