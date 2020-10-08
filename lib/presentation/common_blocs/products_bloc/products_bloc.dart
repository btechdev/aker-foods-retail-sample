import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUseCase productsUseCase;
  List<ProductCategoryEntity> _categories = [];

  int _categoryProductsPage = 1;
  bool _isLastPageFetched = false;
  String _categoryProductsNextUrl;
  final List<ProductEntity> _categoryProducts = [];

  ProductsBloc({this.productsUseCase}) : super(EmptyState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is FetchHomePageProductsEvent) {
      yield* _handleFetchHomePageProductsEvent();
    } else if (event is FetchSearchPageProductsEvent) {
      yield* _handleFetchSearchPageProductsEvent();
    } else if (event is SearchProductsEvent) {
      yield* _handleSearchProductsEvent(event);
    } else if (event is InitiateProductsSearchEvent) {
      yield* _handleInitiateProductsSearchEvent();
    } else if (event is CancelProductsSearchEvent) {
      yield* _handleCancelProductsSearchEvent();
    } else if (event is FetchProductCategoriesEvent) {
      yield* _handleFetchCategoriesEvent();
    } else if (event is FetchProductForCategoriesEvent) {
      yield* _handleProductForCategoriesEvent();
    } else if (event is FetchCategoryProductsEvent) {
      yield* _handleFetchCategoryProductsEvent(event);
    }
  }

  Stream<ProductsState> _handleFetchCategoriesEvent() async* {
    yield ProductCategoriesFetchingState();
    _categories = await productsUseCase.getCategories();
    yield ProductCategoriesFetchSuccessState(categories: _categories);
  }

  Future<List<ProductEntity>> _getCategoryProductsFirstPage(
      ProductCategoryEntity category) async {
    final apiResponse = await productsUseCase.getProductsForCategory(
        categoryId: category.id, pageNumber: 1, pageSize: 4);
    return apiResponse.data;
  }

  Stream<ProductsState> _handleProductForCategoriesEvent() async* {
    final Map<int, List<ProductEntity>> productsMap = {};
    final list = await Future.wait(
      _categories.map(_getCategoryProductsFirstPage),
    );

    for (var i = 0; i < _categories.length; i++) {
      productsMap[_categories[i].id] = list[i];
    }

    yield CategoryWiseProductsFetchSuccessState(
        categories: _categories, categoryProductsMap: productsMap);
  }

  Stream<ProductsState> _handleFetchHomePageProductsEvent() async* {
    yield FetchingProductsState();
    final categories = await productsUseCase.getCategories();
    final products = await productsUseCase.getProducts();
    yield HomePageProductsLoadedState(
      categories: categories,
      products: products,
    );
  }

  Stream<ProductsState> _handleFetchSearchPageProductsEvent() async* {
    yield FetchingProductsState();
    final categories = await productsUseCase.getCategories();
    final products = await productsUseCase.getProducts();
    yield SearchPageProductsLoadedState(
      categories: categories,
      products: products,
    );
  }

  Stream<ProductsState> _handleSearchProductsEvent(
      SearchProductsEvent event) async* {
    //yield FetchingProductsState();
    yield SearchingProductsState();
    final products = await productsUseCase.searchProducts(event.searchText);
    yield ProductsSearchSuccessState(products: products);
  }

  Stream<ProductsState> _handleInitiateProductsSearchEvent() async* {
    yield state.clone();
    /*
    if (state is HomePageProductsLoadedState) {
      final HomePageProductsLoadedState _state = state;
      yield HomePageProductsLoadedState(
        categories: _state.categories,
        products: _state.products,
      );
    } else if (state is SearchPageProductsLoadedState) {
      final SearchPageProductsLoadedState _state = state;
      yield SearchPageProductsLoadedState(
        categories: _state.categories,
        products: _state.products,
      );
    } else if (state is ProductsSearchSuccessState) {
      final ProductsSearchSuccessState _state = state;
      yield ProductsSearchSuccessState(products: _state.products);
    }
    yield EmptyState();*/
  }

  Stream<ProductsState> _handleCancelProductsSearchEvent() async* {
    /*yield FetchingProductsState();
    final categories = await productsUseCase.getCategories();
    final products = await productsUseCase.getProducts();
    yield SearchPageProductsLoadedState(
      categories: categories,
      products: products,
    );*/
    yield EmptyState();
  }

  Stream<ProductsState> _handleFetchCategoryProductsEvent(
      FetchCategoryProductsEvent event) async* {
    if (_isLastPageFetched) {
      return;
    }

    if (_categoryProductsNextUrl == null) {
      yield FetchingProductsState();
    }

    try {
      final apiResponse = await productsUseCase.getProductsForCategory(
        categoryId: event.categoryId,
        pageNumber: _categoryProductsPage,
        pageSize: AppConstants.apiDefaultPageSize,
      );
      _categoryProductsNextUrl = apiResponse.next;
      _isLastPageFetched = _categoryProductsNextUrl == null;
      if (!_isLastPageFetched) {
        _categoryProductsPage++;
      }
      _categoryProducts.addAll(apiResponse.data);
      yield CategoryProductsFetchSuccessState(products: _categoryProducts);
    } catch (_) {}
  }
}
