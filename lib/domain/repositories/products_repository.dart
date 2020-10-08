import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

abstract class ProductsRepository {
  Future<List<ProductCategoryEntity>> getCategories();

  Future<List<ProductEntity>> getProducts();

  Future<List<ProductEntity>> searchProducts(String searchText);

  Future<ApiResponse<ProductEntity>> getProductsForCategory(
      int categoryId, int pageNumber, int pageSize);

  Future<List<ProductEntity>> getProductsForSubcategory(
      int subcategoryId, int pageSize);

  Future<ProductEntity> getProductWithId(int productId);

  Future<bool> notifyUserForProduct(int productId);

  Future<ApiResponse<ProductEntity>> getProductsForCategorySubcategory(
    int categoryId,
    int subcategoryId,
    int pageNumber,
    int pageSize,
  );
}
