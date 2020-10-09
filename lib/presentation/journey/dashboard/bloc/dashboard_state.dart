import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:flutter/foundation.dart';

abstract class DashboardState {
  final int pageIndex;

  DashboardState({this.pageIndex});
}

class PageLoadedState extends DashboardState {
  PageLoadedState({@required int pageIndex}) : super(pageIndex: pageIndex);
}

class FetchingCurrentLocationState extends DashboardState {
  FetchingCurrentLocationState({@required int pageIndex})
      : super(pageIndex: pageIndex);
}

class FetchCurrentLocationSuccessState extends DashboardState {
  AddressEntity address;

  FetchCurrentLocationSuccessState({
    int pageIndex,
    this.address,
  }) : super(pageIndex: pageIndex);
}

class FetchCurrentLocationFailedState extends DashboardState {
  FetchCurrentLocationFailedState({@required int pageIndex})
      : super(pageIndex: pageIndex);
}
