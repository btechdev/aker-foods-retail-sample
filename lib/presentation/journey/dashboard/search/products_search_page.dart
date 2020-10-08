import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/bloc/search_page_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/bloc/search_page_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/bloc/search_page_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/products_category_header.dart';
import 'package:aker_foods_retail/presentation/widgets/products_subcategory_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductsSearchPageState();
}

class ProductsSearchPageState extends State<ProductsSearchPage> {
  final _scrollController = ScrollController();

  bool _searchingProducts;
  FocusNode _searchFieldFocusNode;
  TextEditingController _searchFieldController;

  SearchPageBloc searchPageBloc;
  Map<int, int> productIdCountMap;

  void _scrollControllerListener() {
    final scrollPosition = _scrollController.position;
    if (scrollPosition.maxScrollExtent == scrollPosition.pixels) {
      searchPageBloc.add(FetchSearchPageProductsEvent());
    }
  }

  void _initialiseProductIdCountMap() {
    final cartState = BlocProvider.of<CartBloc>(context).state;
    productIdCountMap =
        cartState is CartLoadedState ? cartState.productIdCountMap : Map();
  }

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Search Page');
    _scrollController.addListener(_scrollControllerListener);
    searchPageBloc = Injector.resolve<SearchPageBloc>();
    _searchingProducts = false;
    _searchFieldFocusNode = FocusNode();
    _searchFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    _searchFieldController.dispose();
    searchPageBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SearchPageBloc, SearchPageState>(
        cubit: searchPageBloc..add(FetchSearchPageProductsEvent()),
        builder: _buildBlocWidget,
      );

  Widget _buildBlocWidget(BuildContext context, SearchPageState state) {
    if (state is FetchingProductsState) {
      return _loaderWithScaffold();
    } else if (state is SearchPageProductsLoadedState) {
      _initialiseProductIdCountMap();
      return _buildSearchPageDefaultContent(state);
    }
    /* else if (state is ProductsSearchSuccessState) {
      categories = [];
      products = state.products;
      _initialiseProductIdCountMap();
      return _buildProductsGrid(context);
    }*/
    return Container();
  }

  Widget _loaderWithScaffold() => Scaffold(
        appBar: _getAppBar(),
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget _buildSearchPageDefaultContent(SearchPageProductsLoadedState state) =>
      Scaffold(
        appBar: _getAppBar(),
        body: _getContent(state),
      );

  Widget _buildProductsGrid(context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _getAppBar(),
        body: _getSearchedProductsGrid(),
      );

  // ======================================================================

  /*AppBar _getAppBar() => AppBar(
        elevation: 8,
        titleSpacing: 0,
        centerTitle: false,
        title: _searchTextFieldContainer(),
        backgroundColor: AppColor.white,
        actions: [
          IconButton(
            icon: Icon(
              _searchingProducts ? Icons.cancel : Icons.search,
              color: AppColor.primaryColor,
            ),
            onPressed: _searchingProducts
                ? _clearSearchTextField
                : _focusSearchTextField,
          ),
        ],
      );*/

  AppBar _getAppBar() => AppBar(
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColor.primaryColor,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteConstants.searchProducts),
          ),
        ],
      );

  Container _searchTextFieldContainer() => Container(
        height: kToolbarHeight,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        child: TextField(
          controller: _searchFieldController,
          focusNode: _searchFieldFocusNode,
          decoration: _searchFieldInputDecoration(),
          style: Theme.of(context).textTheme.bodyText1,
          onChanged: _onSearchProductTextChanged,
        ),
      );

  InputDecoration _searchFieldInputDecoration() => InputDecoration(
        hintText: 'Search Products (minimum 3 letters)',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: AppColor.grey),
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      );

  void _onSearchProductTextChanged(String searchText) {
    /*final trimmedSearchText = searchText.trim();
    if (trimmedSearchText.length >= AppConstants.searchMinTextLength) {
      productsBloc.add(SearchProductsEvent(searchText: trimmedSearchText));
    } else if (trimmedSearchText.isEmpty) {
      productsBloc.add(FetchSearchPageProductsEvent());
    }*/
  }

  void _focusSearchTextField() {
    _searchingProducts = true;
    _searchFieldFocusNode.requestFocus();
    //productsBloc.add(InitiateProductsSearchEvent());
  }

  void _clearSearchTextField() {
    _searchingProducts = false;
    _searchFieldController.clear();
    _searchFieldFocusNode.unfocus();
    //productsBloc.add(CancelProductsSearchEvent());
  }

  // ======================================================================

  Widget _getContent(SearchPageProductsLoadedState state) =>
      SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _getProductsWithCategory(state),
        ),
      );

  List<Widget> _getProductsWithCategory(SearchPageProductsLoadedState state) {
    final widgets = <Widget>[];
    for (int index = 0; index <= state.categoryIndex; index++) {
      if (index >= state.categories.length) {
        break;
      }

      final category = state.categories[index];
      widgets.add(ProductsCategoryHeader(category: category));
      for (final data in state.dataMap[category.id]) {
        if (data.products.isNotEmpty) {
          widgets
            ..add(ProductsSubcategoryHeader(title: data?.subcategory?.name))
            ..add(_productsStaggeredGridView(data.products));
        }
      }
    }
    return widgets;
  }

  StaggeredGridView _productsStaggeredGridView(List<ProductEntity> products) =>
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        crossAxisCount: AppConstants.productsGridCrossAxisCount,
        mainAxisSpacing: LayoutConstants.dimen_8.h,
        crossAxisSpacing: LayoutConstants.dimen_8.w,
        staggeredTileBuilder: (index) =>
            StaggeredTile.extent(1, LayoutConstants.productsGridTileHeight),
        itemBuilder: (context, index) => _productGridTile(products[index]),
        itemCount: products.length,
      );

  Widget _productGridTile(ProductEntity product) => product?.isInStock == true
      ? InStockProductGridTile(
          product: product,
          productQuantityCountInCart: productIdCountMap[product.id] ?? 0,
        )
      : OutOfStockProductGridTile(
          product: product,
          onPressedNotify: () => BlocProvider.of<CartBloc>(context).add(
            NotifyUserAboutProductEvent(productEntity: product),
          ),
        );

  // ======================================================================

  Widget _getSearchedProductsGrid() => SingleChildScrollView(
        primary: true,
        child: Container(
          child: Column(
            children: [
              _productsCountTextContainer(),
              //_searchedProductsGrid(),
            ],
          ),
        ),
      );

  Widget _productsCountTextContainer() => Container(
        color: AppColor.primaryColor35,
        height: LayoutConstants.dimen_48.w,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: Text(
          'Dummy text container',
          //_getProductsResultString(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColor.black,
              ),
        ),
      );

/*String _getProductsResultString() {
    final searchedProductsCount = products.length;
    final trimmedSearchText = _searchFieldController.text.trim();
    return '$searchedProductsCount products found for '
        '\"$trimmedSearchText\" search';
  }

  GridView _searchedProductsGrid() => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        itemCount: products.length,
        gridDelegate: _productsGridDelegate(),
        itemBuilder: (context, index) => _productGridTile(products[index]),
      );

  // ======================================================================

  SliverGridDelegate _productsGridDelegate() =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.productsGridCrossAxisCount,
        childAspectRatio: LayoutConstants.productsGridChildAspectRatio,
        mainAxisSpacing: LayoutConstants.dimen_8.h,
        crossAxisSpacing: LayoutConstants.dimen_8.w,
      );*/
}
