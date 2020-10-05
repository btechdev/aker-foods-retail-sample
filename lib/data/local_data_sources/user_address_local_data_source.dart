import 'dart:convert';

import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class UserAddressLocalDataSource {
  final LocalPreferences localPreferences;

  UserAddressLocalDataSource({
    @required this.localPreferences,
  });

  AddressModel getSelectedAddress() {
    try {
      final selectedAddress =
          localPreferences.get(PreferencesKeys.selectedAddress);
      return selectedAddress == null
          ? null
          : AddressModel.fromJson(json.decode(selectedAddress));
    } catch (_) {}
    return null;
  }

  Future<bool> setSelectedAddress(AddressModel userAddressModel) {
    final userAddressJson = json.encode(AddressModel.toJson(userAddressModel));
    return localPreferences.set(
        PreferencesKeys.selectedAddress, userAddressJson);
  }
}
