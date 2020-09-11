class TransactionEntity {
  final int transactionId;
  final String transactionTitle;
  final String transactionType;
  final double amount;
  final String date;

  TransactionEntity({
    this.transactionId,
    this.transactionTitle,
    this.transactionType,
    this.amount,
    this.date,
  });
}
