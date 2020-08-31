import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/app/app_bloc_listeners.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_bloc_providers.dart';
import 'theme/app_themes.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorStateGlobalKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, widget) {
          PixelDimensionUtil.init(context, allowFontScaling: true);
          return _wrapWithThemedMaterialApp();
        },
      );

  MaterialApp _wrapWithThemedMaterialApp() => MaterialApp(
        navigatorKey: _navigatorStateGlobalKey,
        builder: (context, widget) {
          PixelDimensionUtil.init(
            context,
            allowFontScaling: true,
            navigator: _navigatorStateGlobalKey,
          );
          return MultiBlocProvider(
            providers: getAppStartupBlocProviders(_navigatorStateGlobalKey),
            child: MultiBlocListener(
              listeners: getAppStartupBlocListeners(_navigatorStateGlobalKey),
              child: widget,
            ),
          );
        },
        title: 'Aker Foods Retail',
        theme: AppTheme.defaultTheme(),
        routes: Routes.getAll(),
        initialRoute: RouteConstants.initial,
      );
}
