import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'banner_bloc/banner_bloc.dart';
import 'banner_bloc/banner_event.dart';
import 'banner_bloc/banner_state.dart';

class AkerBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AkerBannerState();
}

class AkerBannerState extends State<AkerBanner> {
  BannerBloc bannerBloc;
  List<BannerDataEntity> bannersDataList = [];

  int _currentBannerIndex;
  PageController _pageController;
  List<Widget> _bannerPages;

  Widget _bannerPageWidget(BannerDataEntity bannerData) => GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          RouteConstants.bannerDetails,
          arguments: bannerData,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: Card(
            elevation: LayoutConstants.cardDefaultElevation,
            color: AppColor.primaryColor35Opaque,
            shape: LayoutConstants.borderlessRoundedRectangle,
            child: Image.network(bannerData.imageUrl),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _currentBannerIndex = 0;
    _pageController = PageController();
    _bannerPages = [];
    bannerBloc = Injector.resolve<BannerBloc>()..add(FetchBannersEvent());
  }

  @override
  void dispose() {
    bannerBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<BannerBloc>(
        create: (context) => bannerBloc,
        child: _wrapBodyWithBloc(),
      );

  BlocBuilder _wrapBodyWithBloc() => BlocBuilder<BannerBloc, BannerState>(
        builder: (context, state) {
          if (state is FetchBannersSuccessState) {
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
