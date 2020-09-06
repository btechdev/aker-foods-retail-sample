import 'package:aker_foods_retail/common/exceptions/server_error_exception.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterNewAddressBloc extends Bloc<UserAddressEvent, EnterNewAddressState> {
  final UserAddressUseCase userAddressUseCase;

  EnterNewAddressBloc({this.userAddressUseCase}) : super(EmptyState());

  @override
  Stream<EnterNewAddressState> mapEventToState(UserAddressEvent event) async* {
    if (event is CreateNewAddressEvent) {
      yield* _handleCreateNewAddressEvent(event);
    } else if (event is SelectSocietyEvent) {
      yield* _handleSocietySelectedEvent(event);
    }
  }

  Stream<EnterNewAddressState> _handleCreateNewAddressEvent(
      CreateNewAddressEvent event) async* {
    yield CreatingNewAddressState();
    try {
      await userAddressUseCase.createNewAddress(event.addressModel);
      yield CreateNewAddressSuccessState();
    } catch (error) {
      if (error is ServerErrorException) {
        yield CreateNewAddressFailedState(errorMessage: error.message);
      }
    }
  }

  Stream<EnterNewAddressState> _handleSocietySelectedEvent(
      SelectSocietyEvent event) async* {
    yield SocietySelectedState(societyModel: event.selectedSociety);
  }
}
