import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';
import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_page_event.dart';
import 'search_page_state.dart';

class PaginatedProductsData {
  int categoryId;
  ProductSubcategoryEntity subcategory;
  List<ProductEntity> products;
  bool hasFetchedLastPage;
  int pageNumber;
  String next;

  PaginatedProductsData({
    this.categoryId,
    this.subcategory,
    this.products,
    this.hasFetchedLastPage = false,
    this.pageNumber = 1,
    this.next,
  });
}

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  final LoaderBloc loaderBloc;
  final ProductsUseCase productsUseCase;

  bool _hasFetchedCategories = false;
  final List<ProductCategoryEntity> _categories = [];
  final Map<int, List<PaginatedProductsData>> _dataMap = Map();
  int _categoryIndex = 0;
  int _newProductsCount = 0;

  SearchPageBloc({
    this.loaderBloc,
    this.productsUseCase,
  }) : super(EmptyState());

  @override
  Stream<SearchPageState> mapEventToState(SearchPageEvent event) async* {
    if (event is FetchSearchPageProductsEvent) {
      yield* _handleFetchSearchPageProductsEvent();
    }
  }

  // ======================================================================

  Future<void> _initialiseDataMap() async {
    _dataMap.clear();
    for (final category in _categories) {
      final List<PaginatedProductsData> paginatedProductsDataList = List();
      if (category.subcategories?.isNotEmpty == true) {
        for (final subcategory in category.subcategories) {
          paginatedProductsDataList.add(
            PaginatedProductsData(
              categoryId: category.id,
              subcategory: subcategory,
              products: [],
            ),
          );
        }
      }
      _dataMap[category.id] = paginatedProductsDataList;
    }
  }

  Future<void> _fetchProductsForCategory() async {
    if (_categoryIndex < 0 || _categoryIndex >= _categories.length) {
      return;
    }

    PaginatedProductsData data;
    final currentCategory = _categories[_categoryIndex];
    final dataList = _dataMap[currentCategory.id];
    if (dataList == null) {
      _categoryIndex++;
      await _fetchProductsForCategory();
      return;
    }

    for (int i = 0; i < dataList.length; i++) {
      data = dataList[i];
      while (!data.hasFetchedLastPage) {
        final apiResponse =
            await productsUseCase.getProductsForCategorySubcategory(
          categoryId: data.categoryId,
          subcategoryId: data.subcategory.id,
          pageNumber: data.pageNumber,
          pageSize: AppConstants.apiDefaultPageSize,
        );
        final List<ProductEntity> newProducts = apiResponse.data;
        _newProductsCount = _newProductsCount + newProducts.length;
        data.products.addAll(newProducts);
        if (apiResponse.next?.isNotEmpty == true) {
          data.pageNumber++;
        } else {
          data.hasFetchedLastPage = true;
        }
        if (_newProductsCount >= AppConstants.apiDefaultPageSize) {
          _newProductsCount = 0;
          return;
        }
      }

      if (_newProductsCount >= AppConstants.apiDefaultPageSize) {
        _newProductsCount = 0;
        return;
      }
    }

    if (_newProductsCount < AppConstants.apiDefaultPageSize) {
      _categoryIndex++;
      await _fetchProductsForCategory();
    }
  }

  // ======================================================================

  Stream<SearchPageState> _handleFetchSearchPageProductsEvent() async* {
    if (!_hasFetchedCategories) {
      yield FetchingProductsState();
      _categories.addAll(await productsUseCase.getCategories());
      _categoryIndex = -1;
      _hasFetchedCategories = true;
      if (_categories.isNotEmpty) {
        await _initialiseDataMap();
        _categoryIndex = 0;
      } else {
        yield SearchPageProductsLoadedState(
          categoryIndex: _categoryIndex,
          categories: _categories,
          dataMap: _dataMap,
        );
        return;
      }
    }

    if (state is! FetchingProductsState) {
      loaderBloc.add(ShowLoaderEvent());
    }
    _newProductsCount = 0;
    await _fetchProductsForCategory();
    yield SearchPageProductsLoadedState(
      categoryIndex: _categoryIndex,
      categories: _categories,
      dataMap: _dataMap,
    );
    loaderBloc.add(DismissLoaderEvent());
  }
}
