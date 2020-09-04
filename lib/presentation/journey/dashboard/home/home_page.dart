import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
    _Product('Onion', '1 kg', '₹ 20'),
    _Product('Tomato', '1 kg', '₹ 80'),
    _Product('Potato', '1 kg', '₹ 25'),
    _Product('Beat Root', '1 kg', '₹ 60'),
    _Product('Carrot', '1 kg', '₹ 40'),
    _Product('Cucumber', '1 kg', '₹ 40'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.white,
        appBar: _getAppBar(),
        body: _getHomePageContent(),
      );

  AppBar _getAppBar() => AppBar(
        elevation: 8,
        titleSpacing: 0,
        centerTitle: false,
        title: _addressContainer(),
        backgroundColor: AppColor.white,
        actions: const [
          Icon(
            Icons.notifications,
            color: AppColor.primaryColor,
          ),
        ],
      );

  Container _addressContainer() => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.dimen_56.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: AppColor.primaryColor,
              size: LayoutConstants.dimen_30.w,
            ),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Text(
                'Splendid County, Lohegaon',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );

  /*Column _getHomePageContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: LayoutConstants.dimen_12.h),
          _bannerContainer(),
          _categoriesCard(),
          SizedBox(height: LayoutConstants.dimen_12.h),
          _homePageProductsGrid(),
        ],
      );*/

  SingleChildScrollView _getHomePageContent() => SingleChildScrollView(
        primary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: LayoutConstants.dimen_12.h),
            _bannerContainer(),
            _categoriesCard(),
            SizedBox(height: LayoutConstants.dimen_12.h),
            _homePageProductsGridListing(),
          ],
        ),
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
        children: [
          Container(
            padding: EdgeInsets.only(
              top: LayoutConstants.dimen_16.h,
              left: LayoutConstants.dimen_16.w,
            ),
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

  /*GridView _homePageProductsGrid() => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.25,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ProductGridItemTile('Onion', '1 kg', '₹ 20'),
          ProductGridItemTile('Tomato', '1 kg', '₹ 80'),
          ProductGridItemTile('Potato', '1 kg', '₹ 25'),
          ProductGridItemTile('Beat Root', '1 kg', '₹ 60'),
          ProductGridItemTile('Carrot', '1 kg', '₹ 40'),
          ProductGridItemTile('Cucumber', '1 kg', '₹ 40'),
        ],
      );*/

  Widget _homePageProductsGridListing() => ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
              color: AppColor.skyBlue.withOpacity(0.35),
              padding:
                  EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                dummyHeaders[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              color: AppColor.primaryColor,
              height: LayoutConstants.dimen_48.h,
            ),
          );
        },
      );

/*Material _categoryItem() => Material(
        child: InkWell(
          child: Column(
            children: [
              CircleAvatar(
                radius: LayoutConstants.dimen_32.w,
                backgroundImage: const ExactAssetImage(
                  'assets/images/user-profile-vegies.jpeg',
                ),
              ),
              Text(
                'Dairy',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColor.primaryColor,
                    ),
              ),
            ],
          ),
        ),
      );*/
}
