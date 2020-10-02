abstract class SelectSocietyEvent {}

class FetchSocietiesFirstPageEvent extends SelectSocietyEvent {}

class SearchSocietiesEvent extends SelectSocietyEvent {
  final String searchKeyword;

  SearchSocietiesEvent({this.searchKeyword});
}

class SearchSocietiesCancelEvent extends SelectSocietyEvent {}
