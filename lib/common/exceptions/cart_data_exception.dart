import 'package:aker_foods_retail/common/constants/exception_constants.dart';
import 'package:aker_foods_retail/network/http/http_util.dart';

import 'server_exception.dart';

class CartDataException extends ServerException {
  final bool hasInvalidPromoCodeApplied;
  final bool hasOutOfStockProducts;
  final Set<String> outOfStockProductIds;

  CartDataException(
    String errorMessage, {
    this.hasInvalidPromoCodeApplied = false,
    this.hasOutOfStockProducts = false,
    this.outOfStockProductIds,
  }) : super(
          codeInt: ExceptionConstants.productOutOfStockCode,
          codeString: ExceptionConstants.productOutOfStockString,
          message: errorMessage,
        );

  factory CartDataException.fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap.containsKey('item_unstocked')) {
      return CartDataException(
        HttpUtil.getErrorMessage(jsonMap['item_unstocked']),
        hasOutOfStockProducts: true,
        outOfStockProductIds:
            _getOutOfStockProductIds(jsonMap['item_unstocked']),
      );
    } else if (jsonMap.containsKey('coupon')) {
      return CartDataException(
        HttpUtil.getErrorMessage(jsonMap['coupon']),
        hasInvalidPromoCodeApplied: true,
      );
    }
    return CartDataException(HttpUtil.getErrorMessage(jsonMap));
  }

  static Set<String> _getOutOfStockProductIds(Map<String, dynamic> jsonMap) {
    if (jsonMap != null) {
      return jsonMap.keys.toSet();
    }
    return Set();
  }
}
