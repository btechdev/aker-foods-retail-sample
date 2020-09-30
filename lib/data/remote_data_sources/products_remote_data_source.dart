import 'package:aker_foods_retail/data/models/product_category_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class ProductsRemoteDataSource {
  final ApiClient apiClient;

  ProductsRemoteDataSource({this.apiClient});

  Future<List<ProductCategoryModel>> getCategories() async {
    final jsonMap = await apiClient.get(ApiEndpoints.categories);
    return ApiResponse.fromJson<ProductCategoryModel>(jsonMap).data;
  }

  Future<List<ProductModel>> getProducts() async {
    final jsonMap = await apiClient.get(ApiEndpoints.products);
    return ApiResponse.fromJson<ProductModel>(jsonMap).data;
  }

  Future<List<ProductModel>> getProductsForCategory({
    int categoryId,
    int pageSize,
  }) async {
    final urlPath = '${ApiEndpoints.products}'
        '?category_id=$categoryId&page_size=$pageSize';
    final jsonMap = await apiClient.get(urlPath);
    return ApiResponse.fromJson<ProductModel>(jsonMap).data;
  }

  Future<List<ProductModel>> getProductsForSubcategory({
    int subcategoryId,
    int pageSize,
  }) async {
    final urlPath = '${ApiEndpoints.products}'
        '?subcategory_id=$subcategoryId&page_size=$pageSize';
    final jsonMap = await apiClient.get(urlPath);
    return ApiResponse.fromJson<ProductModel>(jsonMap).data;
  }

  Future<ProductModel> getProductWithId(int productId) async {
    final urlPath = '${ApiEndpoints.products}$productId';
    final jsonMap = await apiClient.get(urlPath);
    return ProductModel.fromJson(jsonMap);
  }

  Future<bool> postNotifyUserAboutProduct(int productId) async {
    final response = await apiClient.post(
        '${ApiEndpoints.products}$productId/notify_me/', null);
    if (response is Map<String, dynamic>) {
      final message = response['message'];
      return !(message == null);
    } else {
      return Future.value(false);
    }
  }
}
