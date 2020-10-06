import 'package:aker_foods_retail/data/models/product_category_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/products_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({this.productsRemoteDataSource});

  @override
  Future<List<ProductCategoryModel>> getCategories() async =>
      productsRemoteDataSource.getCategories();

  @override
  Future<List<ProductModel>> getProducts() async =>
      productsRemoteDataSource.getProducts();

  @override
  Future<List<ProductModel>> searchProducts(String searchText) async {
    throw UnimplementedError('SearchProducts API is not yet integrated');
  }

  @override
  Future<ApiResponse<ProductModel>> getProductsForCategory(
          int categoryId, int pageNumber, int pageSize) async =>
      productsRemoteDataSource.getProductsForCategory(
          categoryId: categoryId, pageNumber: pageNumber, pageSize: pageSize);

  @override
  Future<List<ProductModel>> getProductsForSubcategory(
          int subcategoryId, int pageSize) async =>
      productsRemoteDataSource.getProductsForSubcategory(
          subcategoryId: subcategoryId, pageSize: pageSize);

  @override
  Future<ProductModel> getProductWithId(int productId) async =>
      productsRemoteDataSource.getProductWithId(productId);

  @override
  Future<bool> notifyUserForProduct(int productId) async =>
      productsRemoteDataSource.postNotifyUserAboutProduct(productId);
}
