import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/bloc/search_page_bloc.dart';

// ignore: one_member_abstracts
abstract class SearchPageState {
  SearchPageState clone();
}

class EmptyState extends SearchPageState {
  @override
  SearchPageState clone() => EmptyState();
}

class FetchingProductsState extends SearchPageState {
  @override
  SearchPageState clone() => FetchingProductsState();
}

class SearchingProductsState extends SearchPageState {
  @override
  SearchPageState clone() => SearchingProductsState();
}

class SearchPageProductsLoadedState extends SearchPageState {
  //====== C ====== SC ====== PP ======
  //====== 1 ====== 1.1 ====== 1.3 ======
  //====== 1 ====== 1.2 ====== 2.2 ======
  //====== 1 ====== 1.3 ====== 3.1 ======
  final int categoryIndex;
  final List<ProductCategoryEntity> categories;
  final Map<int, List<PaginatedProductsData>> dataMap;

  SearchPageProductsLoadedState({
    this.categoryIndex,
    this.categories,
    this.dataMap,
  });

  @override
  SearchPageState clone() => SearchPageProductsLoadedState(
        categoryIndex: categoryIndex,
        categories: categories,
        dataMap: dataMap,
      );
}
