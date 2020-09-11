import 'package:aker_foods_retail/common/exceptions/server_error_exception.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeAddressBloc extends Bloc<ChangeAddressEvent, ChangeAddressState> {
  final UserAddressUseCase userAddressUseCase;

  ChangeAddressBloc({this.userAddressUseCase}) : super(EmptyState());

  @override
  Stream<ChangeAddressState> mapEventToState(ChangeAddressEvent event) async* {
    if (event is FetchAddressesEvent) {
      yield* _handleFetchAddressEvent();
    } else if (event is SelectCurrentAddressEvent) {
      yield* _handleSelectCurrentAddressEvent(event);
    } else if (event is FetchCurrentAddressEvent) {
      yield* _handleFetchCurrentAddressEvent(event);
    }
  }

  Stream<ChangeAddressState> _handleFetchAddressEvent() async* {
    yield FetchingAddressState();
    try {
      final addresses = await userAddressUseCase.getAddresses();
      yield FetchAddressSuccessfulState(addresses: addresses);
    } catch (error) {
      if (error is ServerErrorException) {
        yield FetchAddressFailedState(errorMessage: error.message);
      }
    }
  }

  Stream<ChangeAddressState> _handleSelectCurrentAddressEvent(
      SelectCurrentAddressEvent event) async* {
    final status =
    await userAddressUseCase.setSelectedAddress(event.selectedAddress);
    if (status) {
      try {
        final address = await userAddressUseCase.getSelectedAddress();
        yield address == null
            ? FetchSelectedAddressFailedState()
            : FetchSelectedAddressSuccessState(addressModel: address);

      } catch(error) {
        debugPrint(error);
        yield FetchSelectedAddressFailedState();
      }
    } else {
      yield FetchSelectedAddressFailedState();
    }
  }

  Stream<ChangeAddressState> _handleFetchCurrentAddressEvent(
      FetchCurrentAddressEvent event) async* {
    try {
      final address = await userAddressUseCase.getSelectedAddress();
      yield address == null
          ? FetchSelectedAddressFailedState()
          : FetchSelectedAddressSuccessState(addressModel: address);

    } catch(error) {
      debugPrint(error);
      yield FetchSelectedAddressFailedState();
    }
  }

}
