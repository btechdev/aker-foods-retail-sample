import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductCategoryEntity>> getCategories();

  Future<List<ProductEntity>> getProducts();

  Future<List<ProductEntity>> searchProducts(String searchText);
}
