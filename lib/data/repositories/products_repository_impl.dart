import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  List<String> dummyCategories = [
    'Vegetables',
    'Fruits',
    'Dairy',
  ];
  List<ProductModel> dummyProducts = [
    ProductModel(
        name: 'Onion Onion Onion Onion Onion', quantity: '1 kg', price: 20),
    ProductModel(name: 'Tomato', quantity: '1 kg', price: 80, discount: 0.10),
    ProductModel(name: 'Potato', quantity: '1 kg', price: 25),
    ProductModel(
        name: 'Beat Root', quantity: '1 kg', price: 60, discount: 0.15),
    ProductModel(name: 'Carrot', quantity: '1 kg', price: 40),
    ProductModel(name: 'Cucumber', quantity: '1 kg', price: 40),
  ];

  @override
  Future<List<String>> getCategories() async {
    return dummyCategories;
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    return dummyProducts;
  }

  @override
  Future<List<ProductModel>> searchProducts(String searchText) async {
    return dummyProducts
        .where(
          (product) =>
              product.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }
}
