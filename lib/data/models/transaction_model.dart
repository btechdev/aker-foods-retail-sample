import 'package:aker_foods_retail/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    int transactionId,
    String transactionTitle,
    String transactionType,
    double amount,
    String date,
  }) : super(
          transactionId: transactionId,
          transactionTitle: transactionTitle,
          transactionType: transactionType,
          amount: amount,
          date: date,
        );

  static List<TransactionModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> transactionMapList = jsonMap['results'];
    final list = transactionMapList
        .map((transactionMap) => TransactionModel.fromJson(transactionMap))
        .toList();
    return list;
  }

  factory TransactionModel.fromJson(Map<String, dynamic> jsonMap) =>
      TransactionModel(
        transactionId: jsonMap['transactionId'],
        transactionTitle: jsonMap['transactionTitle'],
        transactionType: jsonMap['transactionType'],
        amount: jsonMap['amount'],
        date: jsonMap['date'],
      );
}
