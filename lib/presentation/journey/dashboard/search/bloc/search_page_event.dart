abstract class SearchPageEvent {}

class FetchSearchPageProductsEvent extends SearchPageEvent {}

class SearchProductsEvent extends SearchPageEvent {
  final String searchText;

  SearchProductsEvent({this.searchText});
}

class InitiateProductsSearchEvent extends SearchPageEvent {}

class CancelProductsSearchEvent extends SearchPageEvent {}
