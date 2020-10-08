import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SearchProductsScreen extends StatefulWidget {
  SearchProductsScreen({Key key}) : super(key: key);

  @override
  SearchProductsScreenState createState() => SearchProductsScreenState();
}

class SearchProductsScreenState extends State<SearchProductsScreen> {
  ProductsBloc productsBloc;
  bool isSearching = false;

  TextEditingController _searchFieldController;
  FocusNode _searchFieldFocusNode;

  Map<int, int> productIdCountMap;

  void _initialiseProductIdCountMap() {
    final cartState = BlocProvider.of<CartBloc>(context).state;
    productIdCountMap =
        cartState is CartLoadedState ? cartState.productIdCountMap : Map();
  }

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'search products screen');
    productsBloc = Injector.resolve<ProductsBloc>();

    _searchFieldFocusNode = FocusNode();
    _searchFieldController = TextEditingController();
    _initialiseProductIdCountMap();
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    _searchFieldController.dispose();
    productsBloc?.close();
    super.dispose();
  }

  void _inFocusSearchTextField() {
    _searchFieldFocusNode.requestFocus();
  }

  void _clearSearchTextField() {
    _searchFieldController.clear();
    productsBloc.add(CancelProductsSearchEvent());
  }

  void _searchTextChanged(String text) {
    if (_searchFieldController.text.trim().isNotEmpty &&
        _searchFieldController.text.trim().length >=
            AppConstants.searchMinTextLength) {
      productsBloc.add(SearchProductsEvent(
        searchText: _searchFieldController.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductsBloc, ProductsState>(
        cubit: productsBloc,
        builder: _buildBlocWidget,
      );

  Widget _buildBlocWidget(BuildContext context, ProductsState state) {
    if (state is EmptyState) {
      return _emptyScaffold(state);
    } else if (state is SearchingProductsState) {
      return _loaderWithScaffold(state);
    } else if (state is ProductsSearchSuccessState) {
      return _buildProductsGridWithScaffold(state);
    }
    return Container();
  }

  Widget _emptyScaffold(ProductsState state) => Scaffold(
        appBar: _getAppBar(state),
        body: Container(),
      );

  Widget _loaderWithScaffold(ProductsState state) => Scaffold(
        appBar: _getAppBar(state),
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget _buildProductsGridWithScaffold(ProductsSearchSuccessState state) =>
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _getAppBar(state),
        body: _productsStaggeredGridView(state.products),
      );

  Widget _productsStaggeredGridView(List<ProductEntity> products) =>
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
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

  AppBar _getAppBar(ProductsState state) => AppBar(
        elevation: 1,
        titleSpacing: 0,
        centerTitle: false,
        title: _getSearchTextField(context),
        actions: _getSearchActions(state),
        backgroundColor: AppColor.white,
      );

  List<Widget> _getSearchActions(ProductsState state) {
    return [
      IconButton(
        icon: Icon(
          (state is SearchingProductsState ||
                  state is ProductsSearchSuccessState ||
                  state is ProductsSearchFailedState)
              ? Icons.cancel
              : Icons.search,
          color: AppColor.primaryColor,
        ),
        onPressed: (state is SearchingProductsState ||
                state is ProductsSearchSuccessState ||
                state is ProductsSearchFailedState)
            ? _clearSearchTextField
            : _inFocusSearchTextField,
      ),
    ];
  }

  TextField _getSearchTextField(context) {
    return TextField(
      controller: _searchFieldController,
      focusNode: _searchFieldFocusNode,
      decoration: _getSearchBarInputDecoration(context),
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: (value) => {_searchTextChanged(value)},
    );
  }

  InputDecoration _getSearchBarInputDecoration(context) {
    return InputDecoration(
      hintText: 'Search Products (min 3 letters)',
      hintStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(color: AppColor.grey),
      border: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }
}
