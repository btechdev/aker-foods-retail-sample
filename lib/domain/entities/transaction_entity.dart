class TransactionEntity {
  final String transactionId;
  final String description;
  final String transactionType;
  final double value;
  final String date;

  TransactionEntity({
    this.transactionId,
    this.description,
    this.transactionType,
    this.value,
    this.date,
  });
}
