import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/banner_bloc/banner_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/banner_bloc/banner_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/banner_bloc/banner_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/products_category_header.dart';
import 'package:aker_foods_retail/presentation/widgets/products_subcategory_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BannerDetailsScreenState();
}

class BannerDetailsScreenState extends State<BannerDetailsScreen> {
  BannerBloc bannerBloc;
  Map<int, int> productIdCountMap;

  BannerDataEntity _bannerData;

  void _initialiseProductIdCountMap() {
    final cartState = BlocProvider.of<CartBloc>(context).state;
    productIdCountMap =
        cartState is CartLoadedState ? cartState.productIdCountMap : Map();
  }

  @override
  void initState() {
    super.initState();
    bannerBloc = Injector.resolve<BannerBloc>();
  }

  @override
  void dispose() {
    bannerBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bannerData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _getAppBar(),
      body: BlocBuilder<BannerBloc, BannerState>(
        cubit: bannerBloc
          ..add(FetchBannerProductsEvent(bannerData: _bannerData)),
        builder: _buildBlocWidget,
      ),
    );
  }

  AppBar _getAppBar() => AppBar(
        elevation: 8,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColor.white,
        title: Text(
          _bannerData?.name ?? 'Banner Title',
          style: Theme.of(context).textTheme.button,
        ),
      );

  Widget _buildBlocWidget(BuildContext context, BannerState state) {
    if (state is FetchingBannerDetailsState) {
      return _loaderContainer();
    } else if (state is FetchBannerCategoryProductsSuccessState) {
      return _wrapWithCustomScrollView(
        _getProductsWithCategorySliversList(
          state.categories,
          state.categoryProductsMap,
        ),
      );
    } else if (state is FetchBannerSubcategoryProductsSuccessState) {
      return _wrapWithCustomScrollView(
        _getProductsWithSubcategorySliversList(
          state.subcategories,
          state.subcategoryProductsMap,
        ),
      );
    } else if (state is FetchBannerProductsSuccessState) {
      return _wrapWithCustomScrollView([
        _productsSliverGridWithPadding(state.products),
      ]);
    } else if (state is FetchBannerDetailsFailedState) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text('$state', textAlign: TextAlign.center),
      );
    }
    return Container();
  }

  Widget _loaderContainer() => Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );

  CustomScrollView _wrapWithCustomScrollView(List<Widget> slivers) {
    _initialiseProductIdCountMap();
    return CustomScrollView(
      primary: true,
      shrinkWrap: true,
      slivers: slivers,
    );
  }

  // ======================================================================

  List<Widget> _getProductsWithCategorySliversList(
    List<ProductCategoryEntity> categories,
    Map<int, List<ProductEntity>> categoryProductsMap,
  ) {
    final List<Widget> slivers = [];
    for (final category in categories) {
      slivers
        ..add(_productsCategoryHeader(category.name))
        ..add(_productsSliverGridWithPadding(categoryProductsMap[category.id]));
    }
    return slivers;
  }

  // ======================================================================

  List<Widget> _getProductsWithSubcategorySliversList(
    List<ProductSubcategoryEntity> subcategories,
    Map<int, List<ProductEntity>> subcategoryProductsMap,
  ) {
    final List<Widget> slivers = [];
    for (final subcategory in subcategories) {
      slivers
        ..add(_productsSubcategoryHeader(subcategory.name))
        ..add(_productsSliverGridWithPadding(
          subcategoryProductsMap[subcategory.id],
        ));
    }
    return slivers;
  }

  // ======================================================================

  SliverToBoxAdapter _productsCategoryHeader(String title) =>
      SliverToBoxAdapter(
        child: ProductsCategoryHeader(title: title),
      );

  SliverToBoxAdapter _productsSubcategoryHeader(String title) =>
      SliverToBoxAdapter(
        child: ProductsSubcategoryHeader(title: title),
      );

  SliverPadding _productsSliverGridWithPadding(List<ProductEntity> products) =>
      SliverPadding(
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        sliver: SliverGrid(
          gridDelegate: _productsGridDelegate(),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _productGridTile(products[index]),
            childCount: products.length,
          ),
        ),
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
