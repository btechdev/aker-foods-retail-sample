import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/common/utils/widget_util.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'product_grid_item_tile.dart';

// TODO(Bhushan): Dummy product class for demo
class _Product {
  final String name;
  final String quantity;
  final String rate;

  _Product(this.name, this.quantity, this.rate);
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> dummyHeaders = [
    'Vegetables',
    'Fruits',
    'Dairy',
  ];
  List<_Product> dummyProducts = [
    _Product('Onion Onion Onion Onion Onion', '1 kg', '₹ 20'),
    _Product('Tomato', '1 kg', '₹ 80'),
    _Product('Potato', '1 kg', '₹ 25'),
    _Product('Beat Root', '1 kg', '₹ 60'),
    _Product('Carrot', '1 kg', '₹ 40'),
    _Product('Cucumber', '1 kg', '₹ 40'),
  ];

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
    final List<String> savedAddresses = List();
    for (int i = 0; i < 10; i++) {
      savedAddresses.add('Address ${i + 1}');
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
      ),
      builder: (BuildContext context) =>
          ChangeAddressModeSelectionBottomSheet(savedAddresses: savedAddresses),
    );
  }

  Widget _getHomePageContent() => CustomScrollView(
        primary: true,
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: LayoutConstants.dimen_12.h),
              _bannerContainer(),
              _categoriesCard(),
              SizedBox(height: LayoutConstants.dimen_12.h),
            ]),
          ),
          _homePageProductsCategoryHeader('Vegetables'),
          _homePageProductsGridWithPadding(),
          _homePageProductsCategoryHeader('Fruits'),
          _homePageProductsGridWithPadding(),
          _homePageProductsCategoryHeader('Dairy'),
          _homePageProductsGridWithPadding(),
        ],
      );

  Container _bannerContainer() => Container(
        height: PixelDimensionUtil().uiHeightPx * 0.35,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        child: Card(
          elevation: 4,
          color: AppColor.skyBlue,
          child: Image.network(
            'https://www.goteso.com/products/assets/images/fruit-and-vegetable-business-management-app.png',
          ),
        ),
      );

  Card _categoriesCard() => Card(
        elevation: 4,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _categoriesCardHeaderRow(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: LayoutConstants.dimen_16.w,
                  vertical: LayoutConstants.dimen_16.h,
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
            padding: EdgeInsets.only(left: LayoutConstants.dimen_16.w),
            child: Text(
              'Shop by Category',
              style: Theme.of(context).textTheme.bodyText1,
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
          _categoryItem(
            title: 'Dairy',
            url: 'https://images.indianexpress.com/2019/10/dairy-1.jpg',
          ),
          SizedBox(width: LayoutConstants.dimen_12.w),
          _categoryItem(
            title: 'Vegetables',
            url:
                'https://cdn.shopify.com/s/files/1/0104/1059/0266/products/vegetables-box.jpg',
          ),
          SizedBox(width: LayoutConstants.dimen_12.w),
          _categoryItem(
            title: 'Fruits',
            url:
                'https://www.luxuryvillasphuketthailand.com/wp-content/uploads/2018/01/Fruits-in-Phuket1-600x600.jpg',
          ),
        ],
      );

  Widget _categoryItem({String title, String url}) => Column(
        children: [
          CircleAvatar(
            radius: LayoutConstants.dimen_32.w,
            backgroundImage: NetworkImage(url),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColor.primaryColor,
                ),
          ),
        ],
      );

  SliverToBoxAdapter _homePageProductsCategoryHeader(String title) =>
      SliverToBoxAdapter(
        child: Container(
          color: AppColor.skyBlue,
          height: LayoutConstants.dimen_48.w,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );

  SliverPadding _homePageProductsGridWithPadding() => SliverPadding(
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_12.w,
          right: LayoutConstants.dimen_12.w,
          bottom: LayoutConstants.dimen_12.h,
        ),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            mainAxisSpacing: LayoutConstants.dimen_8.h,
            crossAxisSpacing: LayoutConstants.dimen_8.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ProductGridItemTile(
                dummyProducts[index].name,
                dummyProducts[index].quantity,
                dummyProducts[index].rate,
              );
            },
            childCount: dummyProducts.length,
          ),
        ),
      );
}
