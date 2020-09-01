import 'package:aker_foods_retail/domain/entities/society_entity.dart';
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
    }
  }

  Stream<SelectSocietyState> _handleFetchSocietiesFirstPageEvent() async* {
    yield FetchingSocietiesState();
    await Future.delayed(const Duration(seconds: 5));
    final List<SocietyEntity> societies =
        await userAddressUseCase.getSocieties();
    yield SocietiesLoadedState(societies: societies);
  }
}
