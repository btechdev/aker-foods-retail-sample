import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loader_constants.dart';

class LoaderBlocWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;
  final Widget child;

  LoaderBlocWidget({
    Key key,
    @required this.navigator,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          child,
          BlocBuilder<LoaderBloc, LoaderState>(
            builder: _buildContainerWithContent,
          ),
        ],
      );

  Widget _buildContainerWithContent(BuildContext context, LoaderState state) {
    return Visibility(
      visible: state.loading,
      child: !state.isTopLoading
          ? _fullScreenContainerWithCenterLoader()
          : _rowWithTopCenterLoader(),
    );
  }

  Container _fullScreenContainerWithCenterLoader() => Container(
        width: PixelDimensionUtil.screenWidth,
        height: PixelDimensionUtil.screenHeight,
        color: AppColor.black25,
        alignment: Alignment.center,
        child: Container(
          width: LoaderConstants.loaderSize,
          height: LoaderConstants.loaderSize,
          child: const CircularLoaderWidget(),
        ),
      );

  Row _rowWithTopCenterLoader() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: LoaderConstants.loaderSize,
            height: LoaderConstants.loaderSize,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: LoaderConstants.topPadding),
            child: const CircularLoaderWidget(),
          ),
        ],
      );
}
