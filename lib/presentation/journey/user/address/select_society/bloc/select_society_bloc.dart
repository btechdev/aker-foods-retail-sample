import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_society_event.dart';
import 'select_society_state.dart';

class SelectSocietyBloc extends Bloc<SelectSocietyEvent, SelectSocietyState> {
  final UserAddressUseCase userAddressUseCase;

  SelectSocietyBloc({this.userAddressUseCase}) : super(EmptyState());

  @override
  Stream<SelectSocietyState> mapEventToState(SelectSocietyEvent event) async* {
    if (event is FetchSocietiesFirstPageEvent) {
      yield* _handleFetchSocietiesFirstPageEvent();
    } else if (event is SearchSocitiesEvent) {
      yield* _handleSearchSocitiesEvent(event);
    } else if (event is SearchSocitiesCancelEvent) {
      yield* _handleFetchSocietiesFirstPageEvent();
    }
  }

  Stream<SelectSocietyState> _handleFetchSocietiesFirstPageEvent() async* {
    yield FetchingSocietiesState();
    final societies = await userAddressUseCase.getSocieties();
    yield SocietiesLoadedState(societies: societies);
  }

  Stream<SelectSocietyState> _handleSearchSocitiesEvent(
      SearchSocitiesEvent event) async* {
    yield SearchingSocietiesState();
    final societies = await userAddressUseCase.getSocieties();
    final filteredSocieties = societies
        .where((society) => society.name
            .toLowerCase()
            .contains(event.searchKeyword.toLowerCase()))
        .toList();
    yield filteredSocieties.isEmpty
        ? SocitiesSearchFailedState()
        : SocitiesSearchSuccessState(societies: filteredSocieties);
  }
}
