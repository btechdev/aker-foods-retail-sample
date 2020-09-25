import 'package:aker_foods_retail/domain/entities/cart_entity.dart';

class PreCheckoutBodyModel {
  Map<String, dynamic> _jsonMap;

  PreCheckoutBodyModel({Map<String, dynamic> jsonMap}) {
    _jsonMap = jsonMap;
  }

  factory PreCheckoutBodyModel.fromCartData(CartEntity cartEntity) =>
      PreCheckoutBodyModel(
        jsonMap: {
          'coupon_code': cartEntity.promoCode,
          'items': cartEntity.products.map((cartProductEntity) {
            return {
              'id': cartProductEntity.product.id,
              'quantity': cartProductEntity.count,
            };
          }).toList(),
        },
      );

  Map<String, dynamic> toJson() => _jsonMap;
}
