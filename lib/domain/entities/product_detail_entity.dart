import 'package:aker_foods_retail/domain/entities/category_detail_entity.dart';

class ProductDetailEntity {
  ProductDetailEntity({
    this.id,
    this.name,
    this.subcategoryId,
    this.subcategoryDetail,
    this.categoryId,
    this.categoryDetail,
    this.baseQuantity,
    this.amount,
    this.discountedAmount,
    this.salesUnit,
    this.image,
    this.inStock,
    this.displayOrder,
    this.isActive,
  });

  int id;
  String name;
  int subcategoryId;
  CategoryDetailEntity subcategoryDetail;
  int categoryId;
  CategoryDetailEntity categoryDetail;
  double baseQuantity;
  String amount;
  String discountedAmount;
  String salesUnit;
  String image;
  int inStock;
  int displayOrder;
  bool isActive;
}