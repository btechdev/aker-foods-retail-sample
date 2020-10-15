import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_profile_user_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  SnackBarBloc snackBarBloc;
  UserProfileUseCase userProfileUseCase;
  UserAddressUseCase userAddressUseCase;

  Set<String> serviceablePinCodes = Set();

  bool _locationServiceDisabled = false;
  bool _locationPermissionDenied = false;
  LocationPermission _locationPermission;
  Position _currentPosition;
  AddressEntity _currentAddress;

  DashboardBloc({
    this.snackBarBloc,
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
      yield* _handleFetchCurrentLocationEvent();
    } else if (event is FetchSavedAddressEvent) {
      yield* _handleFetchSavedAddressEvent();
    }
  }

  Future<void> _handleRegisterUserDeviceEvent() async {
    try {
      final status = await OneSignal.shared.getPermissionSubscriptionState();
      final playerId = status.subscriptionStatus.userId;
      await userProfileUseCase.registerUserDevice(playerId);
    } catch (_) {}
  }

  Stream<DashboardState> _handleFetchCurrentLocationEvent() async* {
    if (_currentAddress != null) {
      yield* _getStateToYield();
      return;
    }

    if ((_locationServiceDisabled ?? false) ||
        (_locationPermissionDenied ?? false)) {
      yield FetchCurrentLocationFailedState(pageIndex: state.pageIndex);
      return;
    }

    if (_currentPosition != null) {
      _currentAddress ??= await _getCurrentPositionAddress();
      yield* _getStateToYield();
      return;
    }

    yield FetchingCurrentLocationState(pageIndex: state.pageIndex);
    if (serviceablePinCodes.isEmpty) {
      await _fetchServiceablePinCodes();
    }

    await _initLocationPermission();
    switch (_locationPermission) {
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        _locationPermissionDenied = true;
        _currentAddress = await userAddressUseCase.getSelectedAddress();
        yield* _getStateToYield();
        break;

      case LocationPermission.always:
      case LocationPermission.whileInUse:
        try {
          _currentPosition = await getCurrentPosition();
          _currentAddress = await _getCurrentPositionAddress();
          yield* _getStateToYield();
          if (serviceablePinCodes.isNotEmpty &&
              _currentAddress.zipCode?.isNotEmpty == true) {
            if (!serviceablePinCodes.contains(_currentAddress.zipCode)) {
              snackBarBloc.add(ShowSnackBarEvent(
                type: CustomSnackBarType.error,
                text: 'Currently unable to provide service at your location',
              ));
            }
          }
        } catch (e) {
          if (e is LocationServiceDisabledException) {
            _locationServiceDisabled = true;
          }
          yield FetchCurrentLocationFailedState(pageIndex: state.pageIndex);
        }
        break;

      default:
    }
  }

  Stream<DashboardState> _handleFetchSavedAddressEvent() async* {
    _currentAddress = await userAddressUseCase.getSelectedAddress();
    yield* _getStateToYield();
  }

  // =======================================================================

  Future<void> _fetchServiceablePinCodes() async {
    try {
      final _serviceablePinCodes =
          await userAddressUseCase.getServiceablePinCodes();
      serviceablePinCodes.clear();
      for (final code in _serviceablePinCodes) {
        serviceablePinCodes.add('$code');
      }
    } catch (e) {
      debugPrint('serviceablePinCodes ==> ${e.toString()}');
    }
  }

  Future<void> _initLocationPermission() async {
    final currentPermission = await checkPermission();
    if (currentPermission == LocationPermission.denied) {
      _locationPermission = await requestPermission();
    } else {
      _locationPermission = currentPermission;
    }
    debugPrint('------Permission: $_locationPermission ---------');
  }

  Stream<DashboardState> _getStateToYield() async* {
    if (_currentAddress == null) {
      yield FetchCurrentLocationFailedState(pageIndex: state.pageIndex);
    }

    yield FetchCurrentLocationSuccessState(
      address: _currentAddress,
      pageIndex: state.pageIndex,
    );
  }

  Future<AddressEntity> _getCurrentPositionAddress() async {
    final geocoderAddress =
        await _getGeocoderAddressFromPosition(_currentPosition);
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
        label: AppConstants.defaultAddressLabel,
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
