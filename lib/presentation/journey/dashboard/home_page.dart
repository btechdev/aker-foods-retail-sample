import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  Column _getHomePageContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: LayoutConstants.dimen_12.h),
          _bannerContainer(),
          _categoriesCard(),
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
