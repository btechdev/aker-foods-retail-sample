import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUseCase productsUseCase;

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
    }
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
    yield FetchingProductsState();
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
    yield FetchingProductsState();
    final categories = await productsUseCase.getCategories();
    final products = await productsUseCase.getProducts();
    yield SearchPageProductsLoadedState(
      categories: categories,
      products: products,
    );
  }
}
