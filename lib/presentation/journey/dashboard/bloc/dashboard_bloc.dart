import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  UserAddressUseCase userAddressUseCase;
  AddressEntity _currentAddress;

  DashboardBloc({this.userAddressUseCase})
      : super(PageLoadedState(pageIndex: 0));

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is NavigateToPageEvent) {
      yield PageLoadedState(pageIndex: event.pageIndex);
    } else if (event is FetchCurrentLocationEvent) {
      yield* _handleFetchCurrentLocationEvent(event);
    }
  }

  Stream<DashboardState> _handleFetchCurrentLocationEvent(
      DashboardEvent event) async* {
    yield FetchingCurrentLocationState(pageIndex: state.pageIndex);
    final permission = await requestPermission();
    debugPrint('------Permission: $permission ---------');
    switch (permission) {
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
    final currentLocation =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final address = await _getPlaceForLatLng(
        currentLocation.latitude, currentLocation.longitude);
    return AddressEntity(
      label: 'DEFAULT',
      address1: address.addressLine,
      address2: '${address.subLocality}, ${address.locality}, '
          '${address.subAdminArea}, ${address.adminArea}',
      zipCode: address.postalCode,
      city: address.locality,
      country: address.countryName,
      latitude: address.coordinates.latitude,
      longitude: address.coordinates.longitude,
    );
  }

  Future<Address> _getPlaceForLatLng(double latitude, double longitude) async {
    try {
      final places = await Geocoder.local
          .findAddressesFromCoordinates(Coordinates(latitude, longitude));
      return places.first;
    } catch (error) {
      debugPrint('err: $error');
      return null;
    }
  }
}
