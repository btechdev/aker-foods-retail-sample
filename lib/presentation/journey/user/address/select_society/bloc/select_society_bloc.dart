import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_society_event.dart';
import 'select_society_state.dart';

class SelectSocietyBloc extends Bloc<SelectSocietyEvent, SelectSocietyState> {
  // TODO(Bhushan): Handle general pagination & search societies pagination
  static const pageSize = 1000;

  final UserAddressUseCase userAddressUseCase;

  final List<SocietyEntity> _societies = [];
  final int _currentPage = 1;

  SelectSocietyBloc({this.userAddressUseCase}) : super(EmptyState());

  @override
  Stream<SelectSocietyState> mapEventToState(SelectSocietyEvent event) async* {
    if (event is FetchSocietiesFirstPageEvent) {
      yield* _handleFetchSocietiesFirstPageEvent();
    } else if (event is SearchSocietiesEvent) {
      yield* _handleSearchSocietiesEvent(event);
    } else if (event is SearchSocietiesCancelEvent) {
      yield* _handleFetchSocietiesFirstPageEvent();
    }
  }

  Stream<SelectSocietyState> _handleFetchSocietiesFirstPageEvent() async* {
    yield FetchingSocietiesState();
    await _fetchSocieties();
    yield SocietiesLoadedState(societies: _societies);
  }

  Stream<SelectSocietyState> _handleSearchSocietiesEvent(
      SearchSocietiesEvent event) async* {
    yield SearchingSocietiesState();
    await _fetchSocieties();
    final filteredSocieties = _societies
        .where((society) => society.name
            .toLowerCase()
            .contains(event.searchKeyword.toLowerCase()))
        .toList();
    yield filteredSocieties.isEmpty
        ? SocitiesSearchFailedState()
        : SocitiesSearchSuccessState(societies: filteredSocieties);
  }

  Future<void> _fetchSocieties() async {
    if (_societies?.isEmpty == true) {
      final response =
          await userAddressUseCase.getSocieties(_currentPage, pageSize);
      _societies.addAll(response.data);
    }
  }
}
