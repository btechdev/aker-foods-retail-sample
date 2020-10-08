import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_profile_user_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  UserProfileUseCase userProfileUseCase;
  UserAddressUseCase userAddressUseCase;
  AddressEntity _currentAddress;

  DashboardBloc({
    this.userProfileUseCase,
    this.userAddressUseCase,
  }) : super(PageLoadedState(pageIndex: 0));

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is NavigateToPageEvent) {
      yield PageLoadedState(pageIndex: event.pageIndex);
    } else if (event is RegisterUserDeviceEvent) {
      await _handleRegisterUserDeviceEvent();
    } else if (event is FetchCurrentLocationEvent) {
      yield* _handleFetchCurrentLocationEvent(event);
    }
  }

  Future<void> _handleRegisterUserDeviceEvent() async {
    try {
      final status = await OneSignal.shared.getPermissionSubscriptionState();
      final playerId = status.subscriptionStatus.userId;
      await userProfileUseCase.registerUserDevice(playerId);
    } catch (_) {}
  }

  Stream<DashboardState> _handleFetchCurrentLocationEvent(
      DashboardEvent event) async* {
    yield FetchingCurrentLocationState(pageIndex: state.pageIndex);
    LocationPermission locationPermission;
    final currentPermission = await checkPermission();
    if (currentPermission == LocationPermission.denied ||
        currentPermission == LocationPermission.deniedForever) {
      locationPermission = await requestPermission();
    } else {
      locationPermission = currentPermission;
    }
    debugPrint('------Permission: $locationPermission ---------');
    switch (locationPermission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        _currentAddress = await userAddressUseCase.getSelectedAddress();
        debugPrint('--------Location: ${_currentAddress.address1}---------');
        yield _currentAddress == null
            ? FetchCurrentLocationFailedState(pageIndex: state.pageIndex)
            : FetchCurrentLocationSuccessState(
                address: _currentAddress, pageIndex: state.pageIndex);
        break;
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        _currentAddress = await _getCurrentLocation();
        debugPrint('--------Location: ${_currentAddress.address1}---------');
        yield _currentAddress == null
            ? FetchCurrentLocationFailedState(pageIndex: state.pageIndex)
            : FetchCurrentLocationSuccessState(
                address: _currentAddress, pageIndex: state.pageIndex);
        break;
      default:
    }
  }

  Future<AddressEntity> _getCurrentLocation() async {
    final currentPosition =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final geocoderAddress =
        await _getGeocoderAddressFromPosition(currentPosition);
    return geocoderAddress == null ? null : _getAddress(geocoderAddress);
  }

  Future<Address> _getGeocoderAddressFromPosition(Position position) async {
    try {
      final places = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude),
      );
      return places.first;
    } catch (error) {
      debugPrint('Error in getting geocoder address: ${error?.toString()}');
      return null;
    }
  }

  AddressEntity _getAddress(Address geocoderAddress) => AddressEntity(
        label: 'DEFAULT',
        address1: geocoderAddress.addressLine,
        address2:
            '${geocoderAddress.subLocality}, ${geocoderAddress.locality}, '
            '${geocoderAddress.subAdminArea}, ${geocoderAddress.adminArea}',
        zipCode: geocoderAddress.postalCode,
        city: geocoderAddress.locality,
        country: geocoderAddress.countryName,
        latitude: geocoderAddress.coordinates.latitude,
        longitude: geocoderAddress.coordinates.longitude,
      );
}
