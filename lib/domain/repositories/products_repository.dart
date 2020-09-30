import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductCategoryEntity>> getCategories();

  Future<List<ProductEntity>> getProducts();

  Future<List<ProductEntity>> searchProducts(String searchText);

  Future<List<ProductEntity>> getProductsForCategory(
      int categoryId, int pageSize);

  Future<List<ProductEntity>> getProductsForSubcategory(
      int subcategoryId, int pageSize);

  Future<ProductEntity> getProductWithId(int productId);

  Future<bool> notifyUserForProduct(int productId);
}
