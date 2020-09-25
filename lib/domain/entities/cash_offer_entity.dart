class CashOfferEntity {
  String id;
  double amount;
  double cashBack;
  bool isSpecial;
  String title;
  String description;

  CashOfferEntity({
    this.id,
    this.title,
    this.description,
    this.amount,
    this.cashBack,
    this.isSpecial,
  });
}
