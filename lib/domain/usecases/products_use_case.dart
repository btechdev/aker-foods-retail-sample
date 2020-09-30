import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';
import 'package:flutter/foundation.dart';

class ProductsUseCase {
  final ProductsRepository productsRepository;

  ProductsUseCase(this.productsRepository);

  Future<List<ProductCategoryEntity>> getCategories() async =>
      productsRepository.getCategories();

  Future<List<ProductEntity>> getProducts() async =>
      productsRepository.getProducts();

  Future<List<ProductEntity>> searchProducts(String searchText) async =>
      productsRepository.searchProducts(searchText);

  Future<List<ProductEntity>> getProductsForCategory({
    @required int categoryId,
    int pageSize,
  }) async =>
      productsRepository.getProductsForCategory(categoryId, pageSize);

  Future<List<ProductEntity>> getProductsForSubcategory({
    @required int subcategoryId,
    int pageSize,
  }) async =>
      productsRepository.getProductsForCategory(subcategoryId, pageSize);

  Future<ProductEntity> getProductWithId({@required int productId}) async =>
      productsRepository.getProductWithId(productId);

  Future<bool> notifyUserForProduct(int productId) async =>
      productsRepository.notifyUserForProduct(productId);
}
