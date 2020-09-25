import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/banner_info_entity.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AkerBanner extends StatefulWidget {

  const AkerBanner({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AkerBannerState();
}

class AkerBannerState extends State<AkerBanner> {
  int _currentBannerIndex;
  PageController _pageController;
  // ignore: close_sinks
  BannerBloc bannerBloc;
  List<BannerInfoEntity> bannersDataList = [];

  List<Widget> _bannerPages;

  Widget _bannerPageWidget(BannerInfoEntity bannerData) => Container(
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        child: Card(
          elevation: LayoutConstants.cardDefaultElevation,
          color: AppColor.primaryColor35Opaque,
          shape: LayoutConstants.borderlessRoundedRectangle,
          child: Image.network(bannerData.imageUrl),
        ),
      );

  @override
  void initState() {
    super.initState();
    _currentBannerIndex = 0;
    _pageController = PageController();
    bannerBloc = Injector.resolve<BannerBloc>()..add(FetchBannerEvent());

    _bannerPages = [];
  }

  @override
  Widget build(BuildContext context) => BlocProvider<BannerBloc>(
    create: (context) => bannerBloc,
    child: _wrapBodyWithBloc(),
  );

  BlocBuilder _wrapBodyWithBloc() => BlocBuilder<BannerBloc, BannerState>(
    builder: (context, state){
      if (state is FetchBannerSuccessState) {
        _bannerPages.clear();
        for (final bannerData in state.banners) {
          _bannerPages.add(_bannerPageWidget(bannerData));
        }
        bannersDataList = state.banners;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getPagesContainer(),
            _indicatorsContainer(),
          ],
        );
      } else {
        return Container();
      }
    },
  );

  Container _getPagesContainer() => Container(
    height: PixelDimensionUtil().uiHeightPx * 0.25,
    child: PageView(
      controller: _pageController,
      onPageChanged: _onBannerChanged,
      children: _bannerPages,
    ),
  );

  Container _indicatorsContainer() => Container(
        height: PixelDimensionUtil().uiHeightPx * 0.05,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: _indicatorsRow(),
      );

  Row _indicatorsRow() {
    int index;
    final indicatorWidgets = List<Widget>();
    for (index = 0; index < bannersDataList.length; index++) {
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
