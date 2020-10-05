abstract class DashboardEvent {
  final int index;

  DashboardEvent(this.index);
}

class NavigateToPageEvent extends DashboardEvent {
  final int pageIndex;

  NavigateToPageEvent({this.pageIndex}) : super(pageIndex ?? 0);
}

class FetchCurrentLocationEvent extends DashboardEvent {
  FetchCurrentLocationEvent() : super(0);
}
