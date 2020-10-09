import 'package:aker_foods_retail/domain/entities/cart_item_detail_entity.dart';
import 'package:aker_foods_retail/domain/entities/shipping_address_entity.dart';

class OrderEntity {

  int id;
  String orderId;
  String status;
  int totalItem;
  String createdAt;
  String deliveredAt;
  double totalAmount;
  double totalDiscountedAmount;
  double subTotal;
  double couponAmount;
  int paymentStatus;
  int paymentType;
  double totalRefund;
  String note;
  ShippingAddressEntity shippingAddressDetails;
  List<CartItemDetailEntity> cartItemDetail;
  double deliveryCharges;

  OrderEntity({
    this.id,
    this.orderId,
    this.status,
    this.totalItem,
    this.createdAt,
    this.deliveredAt,
    this.totalAmount,
    this.totalDiscountedAmount,
    this.subTotal,
    this.couponAmount,
    this.paymentStatus,
    this.paymentType,
    this.totalRefund,
    this.note,
    this.shippingAddressDetails,
    this.cartItemDetail,
    this.deliveryCharges,
  });

  String getPaymentStatus() {
    switch (paymentStatus) {
      case 0: return 'Not Paid';
      break;
      case 1: return 'Partially Paid';
      break;
      case 2: return 'Paid';
      break;
      case 3: return 'Cancelled';
      break;
      default: return 'Unknown';
    }
  }
}
