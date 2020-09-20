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
}
