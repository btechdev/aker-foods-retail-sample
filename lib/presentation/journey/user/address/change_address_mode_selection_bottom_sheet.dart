import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_state.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/change_address_screen.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/choose_your_location/choose_your_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeAddressModeSelectionBottomSheet extends StatefulWidget {
  final Function onAddressChange;

  ChangeAddressModeSelectionBottomSheet({
    @required this.onAddressChange,
  });

  @override
  State<StatefulWidget> createState() =>
      ChangeAddressModeSelectionBottomSheetState();
}

class ChangeAddressModeSelectionBottomSheetState
    extends State<ChangeAddressModeSelectionBottomSheet> {
  ChangeAddressBloc changeAddressBloc;
  List<AddressModel> savedAddresses;

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Change address bottom sheet');
    savedAddresses = [];
    changeAddressBloc = Injector.resolve<ChangeAddressBloc>()
      ..add(FetchAddressesEvent());
  }

  @override
  Widget build(BuildContext context) => BlocProvider<ChangeAddressBloc>(
        create: (context) => changeAddressBloc,
        child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.75,
            initialChildSize: 0.45,
            builder: (context, controller) {
              controller.addListener(() {
                if (controller.position.maxScrollExtent ==
                    controller.position.pixels) {
                  changeAddressBloc.add(FetchAddressesEvent());
                }
              });
              return BlocBuilder<ChangeAddressBloc, ChangeAddressState>(
                builder: (context, state) => ChangeAddressScreen(
                  scrollController: controller,
                  savedAddresses: savedAddresses.isEmpty
                      ? _getAddresses(state)
                      : savedAddresses,
                  onSearchTapped: _showGooglePlacesApiScreen,
                  currentAddress: _getCurrentAddress(state),
                  onSelectAddress: (address) {
                    changeAddressBloc.add(
                        SelectCurrentAddressEvent(selectedAddress: address));
                    widget.onAddressChange(address);
                  },
                  onAddressTypeSelection: _navigateToConfirmLocationOnMapScreen,
                ),
              );
            }),
      );

  List<AddressModel> _getAddresses(ChangeAddressState state) {
    if (state is FetchAddressSuccessfulState ||
        state is FetchAddressPaginationFailedState) {
      changeAddressBloc.add(FetchCurrentAddressEvent());
      savedAddresses = state.addresses;
      return state.addresses;
    } else if (state is FetchSelectedAddressSuccessState) {
      return savedAddresses;
    } else {
      return [];
    }
  }

  AddressModel _getCurrentAddress(ChangeAddressState state) {
    if (state is FetchSelectedAddressSuccessState) {
      return state.addressModel;
    } else {
      return null;
    }
  }

  Future<void> _showGooglePlacesApiScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseYourLocationScreen(isFromSearch: true),
      ),
    );
  }

  Future<void> _navigateToConfirmLocationOnMapScreen(int index) async {
    final status = await Navigator.pushNamed(context, '/choose-location');
    if(status != null && status) {
      Navigator.pop(context, status);
    }
  }
}
