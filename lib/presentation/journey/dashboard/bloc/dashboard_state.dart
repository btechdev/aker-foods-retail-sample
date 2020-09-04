import 'package:flutter/foundation.dart';

abstract class DashboardState {}

class EmptyState extends DashboardState {}

class PageLoadedState extends DashboardState {
  final int pageIndex;

  PageLoadedState({@required this.pageIndex}) : super();
}
