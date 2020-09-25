abstract class ProductsEvent {}

class FetchHomePageProductsEvent extends ProductsEvent {}

class FetchSearchPageProductsEvent extends ProductsEvent {}

class SearchProductsEvent extends ProductsEvent {
  final String searchText;

  SearchProductsEvent({this.searchText});
}

class InitiateProductsSearchEvent extends ProductsEvent {}

class CancelProductsSearchEvent extends ProductsEvent {}

class FetchProductCategoriesEvent extends ProductsEvent {}

class FetchProductForCategoriesEvent extends ProductsEvent {}