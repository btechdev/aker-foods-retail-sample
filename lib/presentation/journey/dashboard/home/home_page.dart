import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/widget_util.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_state.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/aker_banner_widget.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_grid_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/products_category_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // ignore: close_sinks
  ProductsBloc productsBloc;
  Map<int, int> productIdCountMap;

  Widget _categoriesSection;

  void _initialiseProductIdCountMap() {
    final cartState = BlocProvider.of<CartBloc>(context).state;
    productIdCountMap =
        cartState is CartLoadedState ? cartState.productIdCountMap : Map();
  }

  @override
  void initState() {
    super.initState();
    productsBloc = Injector.resolve<ProductsBloc>()
      ..add(FetchProductCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: BlocProvider<ProductsBloc>(
          create: (context) => productsBloc,
          child: _wrapWithBlocBuilder(),
        ),
      );

  AppBar _getAppBar() => AppBar(
        elevation: 8,
        titleSpacing: 0,
        centerTitle: false,
        title: _addressWidget(),
        backgroundColor: AppColor.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: AppColor.primaryColor,
            ),
            onPressed: () => Navigator.of(context)
                .pushNamed(RouteConstants.notificationsList),
          ),
        ],
      );

  Widget _addressWidget() => wrapWithMaterialInkWell(
        context: context,
        backgroundColor: AppColor.transparent,
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        onTap: _showAddressesListingBottomSheet,
        child: Container(
          alignment: Alignment.center,
          height: LayoutConstants.dimen_56.h,
          child: Row(
            children: [
              _addressWidgetIconContainer(),
              _addressWidgetExpandedText(),
            ],
          ),
        ),
      );

  Container _addressWidgetIconContainer() => Container(
        alignment: Alignment.center,
        width: LayoutConstants.dimen_56.h,
        height: LayoutConstants.dimen_56.h,
        child: Icon(
          Icons.location_on,
          color: AppColor.primaryColor,
          size: LayoutConstants.dimen_30.w,
        ),
      );

  Expanded _addressWidgetExpandedText() => Expanded(
        child: Text(
          'Splendid County, Lohegaon, Dhanori',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );

  Future _showAddressesListingBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
      ),
      builder: (BuildContext context) =>
          ChangeAddressModeSelectionBottomSheet(),
    );
  }

  // =======================================================================

  BlocBuilder _wrapWithBlocBuilder() {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        _initialiseProductIdCountMap();
        return _getContent(state);
      },
    );
  }

  Widget _getContent(ProductsState state) => SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: LayoutConstants.dimen_12.h),
            AkerBanner(),
            _categoriesCard(state),
            SizedBox(height: LayoutConstants.dimen_12.h),
            ..._getProductsWithCategory(state),
          ],
        ),
      );

  List<Widget> _getProductsWithCategory(ProductsState state) {
    final slivers = <Widget>[];
    if (state is CategoryWiseProductsFetchSuccessState) {
      for (final category in state.categories) {
        slivers.add(
          ProductsCategoryHeader(hasViewAllOption: true, category: category),
        );
        final products = state.categoryProductsMap[category.id];
        slivers.add(_productsStaggeredGridView(products));
      }
    }
    return slivers;
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

  Card _categoriesCard(ProductsState state) => Card(
        elevation: 4,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _categoriesCardHeaderRow(),
              Container(
                padding: EdgeInsets.only(
                  left: LayoutConstants.dimen_16.w,
                  right: LayoutConstants.dimen_16.w,
                  bottom: LayoutConstants.dimen_16.h,
                ),
                child: _categoriesRow(state),
              ),
            ],
          ),
        ),
      );

  Row _categoriesCardHeaderRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
            child: Text(
              'Shop by Category',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FlatButton(
            onPressed: () => BlocProvider.of<DashboardBloc>(context).add(
              NavigateToPageEvent(
                pageIndex: DashboardBottomNavigationItem.search.index,
              ),
            ),
            child: Text(
              'Show All',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: AppColor.orangeDark,
                    decoration: TextDecoration.underline,
                  ),
            ),
          )
        ],
      );

  Widget _categoriesRow(ProductsState state) {
    if (state is ProductCategoriesFetchSuccessState) {
      final categories = state.categories;
      if (categories.isEmpty) {
        return Container();
      }

      productsBloc.add(FetchProductForCategoriesEvent());
      final categoriesToDisplayCount =
          categories.length < 3 ? categories.length : 3;
      final rowChildren = <Widget>[];
      int i;
      for (i = 0; i < categoriesToDisplayCount; i++) {
        rowChildren.add(_categoryItemInExpandedContainer(
          title: categories[i].name,
          url: categories[i].imageUrl,
        ));
      }
      return _categoriesSection = Row(children: rowChildren);
    } else if (state is CategoryWiseProductsFetchSuccessState) {
      return _categoriesSection;
    } else {
      return Container();
    }
  }

  Expanded _categoryItemInExpandedContainer({String title, String url}) =>
      Expanded(
        flex: 1,
        child: Container(
          child: _categoryItem(title: title, url: url),
        ),
      );

  Widget _categoryItem({String title, String url}) => Column(
        children: [
          CircleAvatar(
            radius: LayoutConstants.dimen_32.w,
            backgroundImage: url?.isNotEmpty == true
                ? NetworkImage(url)
                : const ExactAssetImage(
                    'assets/images/logo_transparent_background.png',
                  ),
            backgroundColor: AppColor.primaryColor35,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColor.primaryColor,
                ),
          ),
        ],
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
