import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_state.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/banner_bloc/banner_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryProductsScreenState();
}

class CategoryProductsScreenState extends State<CategoryProductsScreen> {
  ProductsBloc productsBloc;
  Map<int, int> productIdCountMap;

  ProductCategoryEntity _category;
  final _scrollController = ScrollController();

  void _scrollControllerListener() {
    final scrollPosition = _scrollController.position;
    if (scrollPosition.maxScrollExtent == scrollPosition.pixels) {
      productsBloc.add(FetchCategoryProductsEvent(categoryId: _category.id));
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
    _scrollController.addListener(_scrollControllerListener);
    productsBloc = Injector.resolve<ProductsBloc>();
    _initialiseProductIdCountMap();
  }

  @override
  void dispose() {
    productsBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _getAppBar(),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        cubit: productsBloc
          ..add(FetchCategoryProductsEvent(categoryId: _category.id)),
        builder: _buildBlocWidget,
      ),
    );
  }

  AppBar _getAppBar() => AppBar(
        centerTitle: false,
        elevation: LayoutConstants.dimen_8,
        backgroundColor: AppColor.white,
        title: Text(
          _category?.name ?? 'Category Products',
          style: Theme.of(context).textTheme.button,
        ),
      );

  Widget _buildBlocWidget(BuildContext context, ProductsState state) {
    if (state is FetchingBannerDetailsState) {
      return const CircularLoaderWidget();
    } else if (state is CategoryProductsFetchSuccessState) {
      return Scrollbar(
        child: _productsStaggeredGridView(state.products),
      );
    }
    return Container();
  }

  Widget _productsStaggeredGridView(List<ProductEntity> products) =>
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
        controller: _scrollController,
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
}
