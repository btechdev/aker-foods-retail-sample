import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/enter_new_address_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/common/constants/app_constants.dart';

class ChooseYourLocationScreen extends StatefulWidget {
  final bool isFromSearch;

  ChooseYourLocationScreen({Key key, this.isFromSearch}) : super(key: key);

  @override
  ChooseYourLocationScreenState createState() =>
      ChooseYourLocationScreenState();
}

class ChooseYourLocationScreenState extends State<ChooseYourLocationScreen> {
  Position _currentLocation;
  GoogleMapController mapController;
  GoogleMapsPlaces _places;
  String _selectedLocation;
  final _iconSize = LayoutConstants.dimen_40.w;

  Future<void> _onSearch() async {
    final result = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConstants.kGoogleApiKey,
      mode: Mode.fullscreen,
      location: Location(_currentLocation.latitude, _currentLocation.longitude),
      region: 'in',
    );
    await _getLatLongFor(prediction: result);
  }

  Future<void> getCurrentLocation() async {
    _currentLocation =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await _animateMapToCurrentLocation();
  }

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: AppConstants.kGoogleApiKey);
    getCurrentLocation();
    if (widget.isFromSearch ?? false) {
      Future.delayed(Duration.zero, _onSearch);
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          iconTheme: Theme.of(context).appBarTheme.iconTheme.copyWith(
                color: AppColor.black,
              ),
//          title: _getPlacesSearchTextField(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _onSearch,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: PixelDimensionUtil.screenWidthDp,
              height: PixelDimensionUtil.screenHeightDp * 0.55,
              color: AppColor.primaryColor,
              child: _getStack(),
            ),
            Expanded(
              child: _getBottomContainer(),
            ),
          ],
        ),
      );

  Stack _getStack() {
    final mapWidth = PixelDimensionUtil.screenWidthDp;
    final mapHeight = PixelDimensionUtil.screenHeightDp * 0.55;
    final iconSize = LayoutConstants.dimen_40.w;

    return Stack(
      alignment:
          Alignment(LayoutConstants.dimen_0.w, LayoutConstants.dimen_0.h),
      children: <Widget>[
        Container(width: mapWidth, height: mapHeight, child: _getMap()),
        Positioned(
          top: (mapHeight - _iconSize) / 2,
          right: (mapWidth - _iconSize) / 2,
          child: Icon(
            Icons.location_on,
            size: iconSize,
            color: AppColor.primaryColor,
          ),
        )
      ],
    );
  }

  GoogleMap _getMap() => GoogleMap(
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: AppConstants.akerFoodsLatLng,
          zoom: AppConstants.mapZoomLevel,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _animateMapToCurrentLocation();
        },
        scrollGesturesEnabled: true,
        onCameraIdle: _getPlaceForMapCenter,
      );

  Future<void> _getPlaceForMapCenter() async {
    final middleX = PixelDimensionUtil.screenWidthDp - _iconSize / 2;
    final middleY = PixelDimensionUtil.screenHeightDp - _iconSize / 2;
    final screenCoordinate =
        ScreenCoordinate(x: middleX.round(), y: middleY.round());
    final middlePoint = await mapController.getLatLng(screenCoordinate);
    try {
      final places = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(middlePoint.latitude, middlePoint.longitude));
      setState(() {
        _selectedLocation = places.first?.addressLine ?? '';
      });
      return places;
    } catch (error) {
      debugPrint('err: $error');
    }
  }

  Future<void> _animateMapToCurrentLocation() async {
    await mapController.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentLocation.latitude, _currentLocation.longitude)));
  }

  Future<void> _animateCameraToLocation(Location location) async {
    await mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(location.lat, location.lng)));
  }

  // ignore: unused_element
  PlacesAutocompleteField _getPlacesSearchTextField() =>
      PlacesAutocompleteField(
        apiKey: AppConstants.kGoogleApiKey,
        hint: 'Search Places',
        location:
            Location(_currentLocation.latitude, _currentLocation.longitude),
        offset: 3,
        mode: Mode.fullscreen,
        onSelected: (prediction) => _getLatLongFor(prediction: prediction),
      );

  Future<void> _getLatLongFor({Prediction prediction}) async {
    if (prediction != null) {
      final detail = await _places.getDetailsByPlaceId(prediction.placeId);
      setState(() {
        _selectedLocation = prediction.description;
      });
      await _animateCameraToLocation(detail.result.geometry.location);
    }
  }

  Container _getBottomContainer() => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: LayoutConstants.dimen_8.h,
            color: AppColor.black54,
            offset: Offset(LayoutConstants.dimen_5.h, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
        vertical: LayoutConstants.dimen_16.h,
      ),
      child: _getBottomScrollView());

  SingleChildScrollView _getBottomScrollView() => SingleChildScrollView(
        child: _getAddressDetails(),
      );

  Column _getAddressDetails() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select Delivery Location',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: LayoutConstants.dimen_4.h),
          const Divider(color: AppColor.grey),
          SizedBox(height: LayoutConstants.dimen_8.h),
          Text(
            'Your Location'.toUpperCase(),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: AppColor.grey,
                ),
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getAddressContainer(context),
          SizedBox(height: LayoutConstants.dimen_4.h),
          const Divider(color: AppColor.grey),
          SizedBox(height: LayoutConstants.dimen_24.h),
          _buttonWithContainer(),
        ],
      );

  Container _getAddressContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.dimen_40.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: AppColor.primaryColor,
              size: LayoutConstants.dimen_30.w,
            ),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Text(
                _selectedLocation ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );

  Container _buttonWithContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_48.h,
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: _showEnterAddressDetailsBottomSheet,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'Proceed',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  void _showEnterAddressDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LayoutConstants.dimen_12.w),
          topRight: Radius.circular(LayoutConstants.dimen_12.w),
        ),
      ),
      builder: _buildBottomSheet,
    );
  }

  Widget _buildBottomSheet(BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.90,
        initialChildSize: 0.80,
        builder: (context, controller) => EnterNewAddressScreen(
          scrollController: controller,
        ),
      );
}
