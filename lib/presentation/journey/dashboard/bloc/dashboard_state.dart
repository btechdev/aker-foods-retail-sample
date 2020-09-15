import 'package:flutter/foundation.dart';

abstract class DashboardState {
  final int pageIndex;

  DashboardState({this.pageIndex});
}

class PageLoadedState extends DashboardState {
  PageLoadedState({@required int pageIndex}) : super(pageIndex: pageIndex);
}
