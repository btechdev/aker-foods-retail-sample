import 'package:aker_foods_retail/data/models/category_detail_model.dart';
import 'package:aker_foods_retail/domain/entities/product_detail_entity.dart';

class ProductDetailModel extends ProductDetailEntity {
  ProductDetailModel({
    int id,
    String name,
    int subcategoryId,
    CategoryDetailModel subcategoryDetail,
    int categoryId,
    CategoryDetailModel categoryDetail,
    double baseQuantity,
    String amount,
    String discountedAmount,
    String salesUnit,
    String image,
    int inStock,
    int displayOrder,
    bool isActive,
  }) : super(
          id: id,
          name: name,
          subcategoryId: subcategoryId,
          subcategoryDetail: subcategoryDetail,
          categoryId: categoryId,
          categoryDetail: categoryDetail,
          baseQuantity: baseQuantity,
          amount: amount,
          discountedAmount: discountedAmount,
          salesUnit: salesUnit,
          image: image,
          inStock: inStock,
          displayOrder: displayOrder,
          isActive: isActive,
        );

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: json['id'],
        name: json['name'],
        subcategoryId: json['subcategory_id'],
        subcategoryDetail:
            CategoryDetailModel.fromJson(json['subcategory_detail']),
        categoryId: json['category_id'],
        categoryDetail: CategoryDetailModel.fromJson(json['category_detail']),
        baseQuantity: json['base_quantity'],
        amount: json['amount'],
        discountedAmount: json['discounted_amount'],
        salesUnit: json['sales_unit'],
        image: json['image'],
        inStock: json['in_stock'],
        displayOrder: json['display_order'],
        isActive: json['is_active'],
      );
}
