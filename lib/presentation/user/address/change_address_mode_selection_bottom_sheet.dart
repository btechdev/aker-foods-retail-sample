import 'package:aker_foods_retail/presentation/location/change_address/change_address_screen.dart';
import 'package:flutter/material.dart';

class ChangeAddressModeSelectionBottomSheet extends StatefulWidget {
  final List<String> savedAddresses;

  ChangeAddressModeSelectionBottomSheet({
    this.savedAddresses,
  }) : super();

  @override
  State<StatefulWidget> createState() =>
      ChangeAddressModeSelectionBottomSheetState();
}

class ChangeAddressModeSelectionBottomSheetState
    extends State<ChangeAddressModeSelectionBottomSheet> {
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: widget.savedAddresses?.isNotEmpty == true ? 0.85 : 0.45,
        initialChildSize: 0.45,
        builder: (context, controller) => ChangeAddressScreen(
          scrollController: controller,
          savedAddresses: widget.savedAddresses,
          onSearchTapped: _showGooglePlacesApiScreen,
          onAddressTypeSelection: _navigateToConfirmLocationOnMapScreen,
        ),
      );

  void _showGooglePlacesApiScreen() {}

  void _navigateToConfirmLocationOnMapScreen(int index) {
    Navigator.pushNamed(context, '/choose-location');
    switch (index) {
      case 0:
        debugPrint('Current Location');
        break;
      case 1:
        debugPrint('Add Address');
        break;
    }
  }
}
