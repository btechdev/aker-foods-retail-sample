import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/widget_util.dart';
import 'package:aker_foods_retail/data/repositories/products_repository_impl.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/aker_banner_widget.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/product_grid_item_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/products_category_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: _getHomePageContent(),
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

  Widget _getHomePageContent() => CustomScrollView(
        primary: true,
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: LayoutConstants.dimen_12.h),
              const AkerBanner(),
              _categoriesCard(),
              SizedBox(height: LayoutConstants.dimen_12.h),
            ]),
          ),
          ..._getProductsWithCategorySliversList(),
        ],
      );

  Card _categoriesCard() => Card(
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
                child: _categoriesRow(),
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
            onPressed: () => {},
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

  Row _categoriesRow() => Row(
        children: [
          _categoryItemInExpandedContainer(
            title: 'Vegetables',
            url:
                'https://cdn.shopify.com/s/files/1/0104/1059/0266/products/vegetables-box.jpg',
          ),
          SizedBox(width: LayoutConstants.dimen_12.w),
          _categoryItemInExpandedContainer(
            title: 'Dairy',
            url: 'https://images.indianexpress.com/2019/10/dairy-1.jpg',
          ),
          SizedBox(width: LayoutConstants.dimen_12.w),
          _categoryItemInExpandedContainer(
            title: 'Fruits',
            url:
                'https://www.luxuryvillasphuketthailand.com/wp-content/uploads/2018/01/Fruits-in-Phuket1-600x600.jpg',
          ),
        ],
      );

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
            backgroundImage: NetworkImage(url),
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

  List<Widget> _getProductsWithCategorySliversList() {
    final List<Widget> slivers = [];
    for (final category in ProductsRepositoryImpl.dummyCategories) {
      slivers
        ..add(_productsCategoryHeader(category))
        ..add(_productsSliverGridWithPadding());
    }
    return slivers;
  }

  SliverToBoxAdapter _productsCategoryHeader(String title) =>
      SliverToBoxAdapter(
        child: ProductsCategoryHeader(title: title),
      );

  SliverPadding _productsSliverGridWithPadding() => SliverPadding(
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppConstants.productsGridCrossAxisCount,
            childAspectRatio: LayoutConstants.productsGridChildAspectRatio,
            mainAxisSpacing: LayoutConstants.dimen_8.h,
            crossAxisSpacing: LayoutConstants.dimen_8.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ProductGridItemTile(
                product: ProductsRepositoryImpl.dummyProducts[index],
              );
            },
            childCount: ProductsRepositoryImpl.dummyProducts.length,
          ),
        ),
      );
}
