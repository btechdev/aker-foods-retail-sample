import 'package:aker_foods_retail/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    String transactionId,
    String description,
    String transactionType,
    double value,
    String date,
  }) : super(
          transactionId: transactionId,
          description: description,
          transactionType: transactionType,
          value: value,
          date: date,
        );

  // ignore: prefer_constructors_over_static_methods
  static TransactionModel fromJson(Map<String, dynamic> jsonMap) =>
      TransactionModel(
        transactionId: jsonMap['id'],
        description: jsonMap['description'],
        transactionType: jsonMap['status'],
        value: jsonMap['value'],
        date: jsonMap['created_at'],
      );
}
