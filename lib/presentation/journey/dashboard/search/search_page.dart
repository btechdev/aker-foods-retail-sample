import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/products_category_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool _searchingProducts;
  FocusNode _searchFieldFocusNode;
  TextEditingController _searchFieldController;

  ProductsBloc productsBloc;
  Map<int, int> productIdCountMap;

  List<ProductCategoryEntity> categories;
  List<ProductEntity> products;

  void _initialiseProductIdCountMap() {
    final cartState = BlocProvider.of<CartBloc>(context).state;
    productIdCountMap =
        cartState is CartLoadedState ? cartState.productIdCountMap : Map();
  }

  @override
  void initState() {
    super.initState();
    _searchingProducts = false;
    _searchFieldFocusNode = FocusNode();
    _searchFieldController = TextEditingController();

    productsBloc = Injector.resolve<ProductsBloc>()
      ..add(FetchSearchPageProductsEvent());
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    _searchFieldController.dispose();
    productsBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductsBloc, ProductsState>(
        cubit: productsBloc,
        builder: _buildBlocWidget,
      );

  Widget _buildBlocWidget(BuildContext context, ProductsState state) {
    if (state is FetchingProductsState) {
      return _loaderWithScaffold();
    } else if (state is SearchPageProductsLoadedState) {
      categories = state.categories;
      products = state.products;
      _initialiseProductIdCountMap();
      return _buildProductsSliverList(context);
    } else if (state is ProductsSearchSuccessState) {
      categories = [];
      products = state.products;
      _initialiseProductIdCountMap();
      return _buildProductsGrid(context);
    }
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Text(
        '$state',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _loaderWithScaffold() => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget _buildProductsSliverList(context) => Scaffold(
        appBar: _getAppBar(),
        body: _getSearchPageDefaultContent(),
      );

  Widget _buildProductsGrid(context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _getAppBar(),
        body: _getSearchedProductsGrid(),
      );

  // ======================================================================

  AppBar _getAppBar() => AppBar(
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
    final trimmedSearchText = searchText.trim();
    if (trimmedSearchText.length >= AppConstants.searchMinTextLength) {
      productsBloc.add(SearchProductsEvent(searchText: trimmedSearchText));
    } else if (trimmedSearchText.isEmpty) {
      productsBloc.add(FetchSearchPageProductsEvent());
    }
  }

  void _focusSearchTextField() {
    _searchingProducts = true;
    _searchFieldFocusNode.requestFocus();
    productsBloc.add(InitiateProductsSearchEvent());
  }

  void _clearSearchTextField() {
    _searchingProducts = false;
    _searchFieldController.clear();
    _searchFieldFocusNode.unfocus();
    productsBloc.add(CancelProductsSearchEvent());
  }

  // ======================================================================

  Widget _getSearchPageDefaultContent() => CustomScrollView(
        primary: true,
        shrinkWrap: true,
        slivers: _getProductsWithCategorySliversList(),
      );

  List<Widget> _getProductsWithCategorySliversList() {
    final List<Widget> slivers = [];
    for (final category in categories) {
      final categoryProducts = products
          .where((product) => category.id == product.categoryId)
          .toList();
      slivers
        ..add(_productsCategoryHeader(category))
        ..add(_productsSliverGridWithPadding(categoryProducts));
    }
    return slivers;
  }

  SliverToBoxAdapter _productsCategoryHeader(ProductCategoryEntity category) =>
      SliverToBoxAdapter(
        child: ProductsCategoryHeader(category: category),
      );

  /*SliverPadding _productsSliverGridWithPadding(
          List<ProductEntity> categoryProducts) =>
      SliverPadding(
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        sliver: SliverGrid(
          gridDelegate: _productsGridDelegate(),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _productGridTile(categoryProducts[index]),
            childCount: categoryProducts.length,
          ),
        ),
      );*/
  SliverPadding _productsSliverGridWithPadding(
          List<ProductEntity> categoryProducts) =>
      SliverPadding(
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        sliver: SliverStaggeredGrid.countBuilder(
          crossAxisCount: AppConstants.productsGridCrossAxisCount,
          mainAxisSpacing: LayoutConstants.dimen_8.h,
          crossAxisSpacing: LayoutConstants.dimen_8.w,
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          itemBuilder: (context, index) => _productGridTile(products[index]),
          itemCount: products.length,
        ),
      );

  // ======================================================================

  Widget _getSearchedProductsGrid() => SingleChildScrollView(
        primary: true,
        child: Container(
          child: Column(
            children: [
              _productsCountTextContainer(),
              _searchedProductsGrid(),
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
          _getProductsResultString(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColor.black,
              ),
        ),
      );

  String _getProductsResultString() {
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
      );

  Widget _productGridTile(ProductEntity product) => product?.isInStock == true
      ? InStockProductGridTile(
          product: product,
          productQuantityCountInCart: productIdCountMap[product.id] ?? 0,
        )
      : OutOfStockProductGridTile(
          product: product,
          onPressedNotify: () => {},
        );
}
