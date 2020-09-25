import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';

class CashOfferModel extends CashOfferEntity {
  CashOfferModel({
    String id,
    double amount,
    double cashBack,
    bool isSpecial,
    String title,
    String description,
  }) : super(
            id: id,
            amount: amount,
            cashBack: cashBack,
            isSpecial: isSpecial,
            title: title,
            description: description);

  static CashOfferModel fromJson(Map<String, dynamic> json) => CashOfferModel(
        id: json['id'],
        amount: json['amount'],
        cashBack: json['cash_back'],
        isSpecial: json['is_special'],
        title: json['title'],
        description: json['description'],
      );
}
