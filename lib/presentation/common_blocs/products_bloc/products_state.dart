import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';

// ignore: one_member_abstracts
abstract class ProductsState {
  ProductsState clone();
}

class EmptyState extends ProductsState {
  @override
  ProductsState clone() => EmptyState();
}

class FetchingProductsState extends ProductsState {
  @override
  ProductsState clone() => FetchingProductsState();
}

class SearchingProductsState extends ProductsState {
  @override
  ProductsState clone() => SearchingProductsState();
}

class HomePageProductsLoadedState extends ProductsState {
  final List<ProductCategoryEntity> categories;
  final List<ProductEntity> products;

  HomePageProductsLoadedState({this.categories, this.products});

  @override
  ProductsState clone() => HomePageProductsLoadedState(
        categories: categories,
        products: products,
      );
}

class SearchPageProductsLoadedState extends ProductsState {
  final List<ProductCategoryEntity> categories;
  final List<ProductEntity> products;

  SearchPageProductsLoadedState({this.categories, this.products});

  @override
  ProductsState clone() => SearchPageProductsLoadedState(
        categories: categories,
        products: products,
      );
}

class ProductsSearchSuccessState extends ProductsState {
  final List<ProductEntity> products;

  ProductsSearchSuccessState({this.products});

  @override
  ProductsState clone() => ProductsSearchSuccessState(products: products);
}

class ProductsFetchFailedState extends ProductsState {
  @override
  ProductsState clone() => ProductsFetchFailedState();
}

class ProductsSearchFailedState extends ProductsState {
  @override
  ProductsState clone() => ProductsSearchFailedState();
}
