import 'package:aker_foods_retail/presentation/theme/app_themes.dart';
import 'package:flutter/material.dart';

// How to use: Any Widget in the app can access the ThemeUpdater
// because it is an InheritedWidget. Then the Widget can call
// ThemeUpdater.of(context).appTheme = [blah]
// to change the theme. The ThemeChanger
// then accesses AppThemeState by using the _appThemeGlobalKey, and
// the ThemeUpdater switches out the old ThemeData for the new ThemeData
// in the AppThemeState (which causes a re-render).

final _appThemeGlobalKey = GlobalKey(debugLabel: 'app_theme');

class AppThemeUpdater extends StatefulWidget {
  final Widget child;

  AppThemeUpdater({this.child}) : super(key: _appThemeGlobalKey);

  @override
  AppThemeUpdaterState createState() => AppThemeUpdaterState();
}

class AppThemeUpdaterState extends State<AppThemeUpdater> {
  ThemeData _currentThemeData = AppTheme.defaultTheme();

  set themeData(ThemeData newThemeData) {
    if (newThemeData != _currentThemeData) {
      setState(() => _currentThemeData = newThemeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeUpdater(
      appThemeKey: _appThemeGlobalKey,
      child: Theme(
        data: _currentThemeData,
        child: widget.child,
      ),
    );
  }
}

class ThemeUpdater extends InheritedWidget {
  static ThemeUpdater of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeUpdater>();

  final ThemeData themeData;
  final GlobalKey _appThemeKey;

  ThemeUpdater({
    GlobalKey appThemeKey,
    this.themeData,
    Widget child,
  })  : _appThemeKey = appThemeKey,
        super(child: child);

  set appTheme(ThemeData newThemeData) {
    final AppThemeUpdaterState appThemeUpdaterState =
        _appThemeKey.currentState as dynamic;
    appThemeUpdaterState?.themeData = newThemeData;
  }

  @override
  bool updateShouldNotify(ThemeUpdater oldWidget) {
    return oldWidget.themeData == themeData;
  }
}
