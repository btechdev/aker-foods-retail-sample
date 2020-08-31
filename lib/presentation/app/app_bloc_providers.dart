import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getAppStartupBlocProviders(
  GlobalKey<NavigatorState> navigatorStateGlobalKey,
) =>
    [
      BlocProvider<SnackBarBloc>(
        create: (BuildContext context) => Injector.resolve<SnackBarBloc>(),
      ),
    ];