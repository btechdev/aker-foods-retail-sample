import 'package:aker_foods_retail/domain/entities/cart_entity.dart';

class CreateOrderBodyModel {
  Map<String, dynamic> _jsonMap;

  CreateOrderBodyModel({Map<String, dynamic> jsonMap}) {
    _jsonMap = jsonMap;
  }

  factory CreateOrderBodyModel.fromData(
    int paymentMode,
    int selectedAddressId,
    CartEntity cartEntity,
  ) =>
      CreateOrderBodyModel(
        jsonMap: {
          'payment_mode': paymentMode,
          'shipping_address_id': selectedAddressId,
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
