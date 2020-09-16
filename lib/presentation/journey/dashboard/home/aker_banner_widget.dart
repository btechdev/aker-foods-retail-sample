import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

// TODO(Bhushan): Remove this once actual entity is created
class _BannerDataEntity {
  final String url;
  final String routeName;
  final dynamic arguments;

  const _BannerDataEntity({
    this.url,
    this.routeName,
    this.arguments,
  });
}

class AkerBanner extends StatefulWidget {
  final List<_BannerDataEntity> bannersDataList;

  const AkerBanner({
    Key key,
    this.bannersDataList = _dummyBanners,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AkerBannerState();

  static const List<_BannerDataEntity> _dummyBanners = [
    _BannerDataEntity(
      url: 'https://www.goteso.com/products/assets/'
          'images/fruit-and-vegetable-business-management-app.png',
    ),
    _BannerDataEntity(
      url: 'https://www.goteso.com/products/assets/'
          'images/fruit-and-vegetable-business-management-app.png',
    ),
    _BannerDataEntity(
      url: 'https://www.goteso.com/products/assets/'
          'images/fruit-and-vegetable-business-management-app.png',
    ),
    _BannerDataEntity(
      url: 'https://www.goteso.com/products/assets/'
          'images/fruit-and-vegetable-business-management-app.png',
    ),
  ];
}

class AkerBannerState extends State<AkerBanner> {
  int _currentBannerIndex;
  PageController _pageController;

  List<Widget> _bannerPages;

  Widget _bannerPageWidget(_BannerDataEntity bannerData) => Container(
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        child: Card(
          elevation: LayoutConstants.cardDefaultElevation,
          color: AppColor.primaryColor35Opaque,
          shape: LayoutConstants.borderlessRoundedRectangle,
          child: Image.network(bannerData.url),
        ),
      );

  @override
  void initState() {
    super.initState();
    _currentBannerIndex = 0;
    _pageController = PageController();

    _bannerPages = [];
    for (final bannerData in widget.bannersDataList) {
      _bannerPages.add(_bannerPageWidget(bannerData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: PixelDimensionUtil().uiHeightPx * 0.25,
          child: PageView(
            controller: _pageController,
            onPageChanged: _onBannerChanged,
            children: _bannerPages,
          ),
        ),
        _indicatorsContainer(),
      ],
    );
  }

  Container _indicatorsContainer() => Container(
        height: PixelDimensionUtil().uiHeightPx * 0.05,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: _indicatorsRow(),
      );

  Row _indicatorsRow() {
    int index;
    final List<Widget> indicatorWidgets = List();
    for (index = 0; index < widget.bannersDataList.length; index++) {
      indicatorWidgets.add(
        index == _currentBannerIndex
            ? _indicator(LayoutConstants.dimen_10.w, AppColor.orangeDark)
            : _indicator(LayoutConstants.dimen_6.w, AppColor.primaryColor35),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicatorWidgets,
    );
  }

  Container _indicator(num size, Color color) => Container(
        width: size,
        height: size,
        margin: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_4.w),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  void _onBannerChanged(int index) {
    setState(() {
      _currentBannerIndex = index;
    });
  }
}
