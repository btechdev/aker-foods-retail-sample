import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';

class ProductsUseCase {
  final ProductsRepository productsRepository;

  ProductsUseCase(this.productsRepository);

  Future<List<String>> getCategories() async =>
      productsRepository.getCategories();

  Future<List<ProductEntity>> getProducts() async =>
      productsRepository.getProducts();

  Future<List<ProductEntity>> searchProducts(String searchText) async =>
      productsRepository.searchProducts(searchText);
}
