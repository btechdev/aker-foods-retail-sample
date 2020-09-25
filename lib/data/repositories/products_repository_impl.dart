import 'package:aker_foods_retail/data/models/product_category_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/products_remote_data_source.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({this.productsRemoteDataSource});

  // TODO(Bhushan): Remove this and dependencies
  static List<String> dummyCategories = [
    'Vegetables',
    'Fruits',
    'Dairy',
  ];

  static List<ProductModel> dummyProducts = [
    ProductModel(name: 'Onion Onion Onion Onion Onion', amount: 20),
    ProductModel(name: 'Tomato', amount: 80),
    ProductModel(name: 'Potato', amount: 25),
    ProductModel(name: 'Beat Root', amount: 60),
    ProductModel(name: 'Carrot', amount: 40),
    ProductModel(name: 'Cucumber', amount: 40),
  ];

  @override
  Future<List<ProductCategoryModel>> getCategories() async =>
      productsRemoteDataSource.getCategories();

  @override
  Future<List<ProductModel>> getProducts() async =>
      productsRemoteDataSource.getProducts();

  @override
  Future<List<ProductModel>> searchProducts(String searchText) async {
    return dummyProducts
        .where(
          (product) =>
              product.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<List<ProductModel>> getProductsForCategories(
          int cid, int pageSize) async =>
      productsRemoteDataSource.getProductsForCategory(
          cid: cid, pageSize: pageSize);
}
