abstract class SelectSocietyEvent {}

class FetchSocietiesFirstPageEvent extends SelectSocietyEvent {}

class SearchSocitiesEvent extends SelectSocietyEvent {
  final String searchKeyword;

  SearchSocitiesEvent({this.searchKeyword});
}

class SearchSocitiesCancelEvent extends SelectSocietyEvent {}
