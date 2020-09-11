import 'package:aker_foods_retail/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    int id,
    String description,
    double amount,
    String date,
    String status,
    int rating,
  }) : super(
          id: id,
          description: description,
          amount: amount,
          date: date,
          status: status,
          rating: rating,
        );

  static List<OrderModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> orderMapList = jsonMap['results'];
    return orderMapList
        .map((orderMap) => OrderModel.fromJson(orderMap))
        .toList();
  }

  factory OrderModel.fromJson(Map<String, dynamic> jsonMap) => OrderModel(
        id: jsonMap['orderId'],
        description: jsonMap['orderDescription'],
        amount: jsonMap['orderAmount'],
        date: jsonMap['orderDate'],
        status: jsonMap['orderStatus'],
      );
}
