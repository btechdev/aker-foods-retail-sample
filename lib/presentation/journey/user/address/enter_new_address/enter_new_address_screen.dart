import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/user_address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/domain/entities/user_address_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_state.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/select_society/address_tag_button.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../../common/extensions/pixel_dimension_util_extensions.dart';

class EnterNewAddressScreen extends StatefulWidget {
  final ScrollController scrollController;

  EnterNewAddressScreen({this.scrollController});

  @override
  EnterNewAddressScreenState createState() => EnterNewAddressScreenState();
}

class EnterNewAddressScreenState extends State<EnterNewAddressScreen> {
   TextEditingController _flatDetailsTextController;
   TextEditingController _landmarkTextController;
   TextEditingController _pincodeTextController;
  final mapLocation = LocationEntity(latitude: 22.22, longitude: 82.22);
   SocietyModel selectedSociety;
  AddressTagType addressTagType;

  // ignore: close_sinks
  EnterNewAddressBloc enterNewAddressBloc;

  bool get _validateFields {
    if (_flatDetailsTextController.text.trim().isNotEmpty &&
        _landmarkTextController.text.trim().isNotEmpty &&
        _pincodeTextController.text.trim().isNotEmpty &&
        mapLocation != null &&
        selectedSociety != null &&
        addressTagType != null) {
      return true;
    } else {
      return false;
    }
  }

  void _createNewAddress() {
    var addressType = '';
    switch (addressTagType) {
      case AddressTagType.home:
        addressType = 'Home';
        break;
      case AddressTagType.office:
        addressType = 'Office';
        break;
      case AddressTagType.other:
        addressType = 'Other';
        break;
    }
    final newAddress = UserAddressModel(
      label: addressType,
      address1: _flatDetailsTextController.text,
      address2: _landmarkTextController.text,
      country: 'India',
      city: 'Pune',
      zipCode: double.parse(_pincodeTextController.text),
      society: selectedSociety,
      location: LocationModel(
          latitude: mapLocation.latitude, longitude: mapLocation.longitude),
    );

    enterNewAddressBloc.add(CreateNewAddressEvent(addressModel: newAddress));
  }

  void _showSnackbar() {
    Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
      text: 'Fields marked * must be filled',
      type: CustomSnackBarType.error,
      position: CustomSnackBarPosition.top,
    ));
  }

  @override
  void initState() {
    super.initState();
    enterNewAddressBloc = Injector.resolve<EnterNewAddressBloc>();
     _flatDetailsTextController = TextEditingController();
     _landmarkTextController = TextEditingController();
     _pincodeTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<EnterNewAddressBloc>(
        create: (context) => enterNewAddressBloc,
        child: Scaffold(
          backgroundColor: AppColor.transparent,
          body: KeyboardAvoider(
            autoScroll: true,
            child: _getBodyWrappedWithBloc(),
          ),
        ),
      );

  Widget _buildForm(BuildContext context, EnterNewAddressState state) =>
      SingleChildScrollView(
        controller: widget.scrollController,
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w,
          right: LayoutConstants.dimen_16.w,
          top: LayoutConstants.dimen_16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getHeader(context),
            SizedBox(height: LayoutConstants.dimen_16.h),
            _getSelectedLocationContainer(context),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(
              context,
              _flatDetailsTextController,
              'Flat/Building Details *',
            ),
            const Divider(color: AppColor.grey),
            _getSocietyFieldContainer(
                context, 'Society Name *', selectedSociety?.name ?? ''),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(
              context,
              _landmarkTextController,
              'Landmark *',
            ),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(
              context,
              _pincodeTextController,
              'Pincode *',
            ),
            const Divider(color: AppColor.grey),
            SizedBox(height: LayoutConstants.dimen_20.h),
            Text(
              'This address is of your:',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.black54,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: LayoutConstants.dimen_8.w),
                AddressTagButton(
                  type: AddressTagType.home,
                  title: 'Home',
                  onSelect: () {
                    addressTagType = AddressTagType.home;
                  },
                ),
                SizedBox(width: LayoutConstants.dimen_8.w),
                AddressTagButton(
                  type: AddressTagType.office,
                  title: 'Office',
                  onSelect: () {
                    addressTagType = AddressTagType.office;
                  },
                ),
                SizedBox(width: LayoutConstants.dimen_8.w),
                AddressTagButton(
                  type: AddressTagType.other,
                  title: 'Other',
                  onSelect: () {
                    addressTagType = AddressTagType.other;
                  },
                ),
              ],
            ),
            SizedBox(height: LayoutConstants.dimen_24.h),
            _buttonWithContainer(context),
          ],
        ),
      );

  BlocListener<EnterNewAddressBloc, EnterNewAddressState>
      _getBodyWrappedWithBloc() =>
          BlocListener<EnterNewAddressBloc, EnterNewAddressState>(
            listener: (context, state) {
              if (state is CreateNewAddressSuccessState) {
                Navigator.pushNamed(context, RouteConstants.myAccount);
                Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
                  text: 'User Profile created',
                  type: CustomSnackBarType.success,
                  position: CustomSnackBarPosition.top,
                ));
              } else if (state is CreateNewAddressFailedState) {
                Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
                  text: state.errorMessage,
                  type: CustomSnackBarType.error,
                  position: CustomSnackBarPosition.top,
                ));
              }
            },
            child: BlocBuilder<EnterNewAddressBloc, EnterNewAddressState>(
              builder: _buildForm,
            ),
          );

  Row _getHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Enter Address Details',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          alignment: Alignment.center,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Future<void> _navigateToSelectSociety(BuildContext context) async {
    final society = await Navigator.pushNamed(
      context,
      RouteConstants.selectSociety,
    );

    if (society is SocietyEntity) {
      selectedSociety = society;
      enterNewAddressBloc.add(SelectSocietyEvent(selectedSociety: society));
    }
  }

  Container _getSocietyFieldContainer(
    BuildContext context,
    String hintText,
    String text,
  ) =>
      Container(
        height: LayoutConstants.dimen_52.h,
        padding: EdgeInsets.only(top: LayoutConstants.dimen_8.h),
        child: InkWell(
          onTap: () => _navigateToSelectSociety(context),
          child: TextField(
            controller: TextEditingController()..text = text,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: _getInputDecoration(
              context: context,
              hintText: hintText,
            ),
            enabled: false,
          ),
        ),
      );

  Container _getTextFieldContainer(BuildContext context,
          TextEditingController controller, String hintText) =>
      Container(
        height: LayoutConstants.dimen_52.h,
        padding: EdgeInsets.only(top: LayoutConstants.dimen_8.h),
        child: TextField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: _getInputDecoration(
            context: context,
            hintText: hintText,
          ),
        ),
      );

  InputDecoration _getInputDecoration(
          {BuildContext context, String hintText}) =>
      InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.only(left: LayoutConstants.dimen_16.w),
        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColor.grey,
            ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      );

  BlocBuilder _buttonWithContainer(BuildContext context) =>
      BlocBuilder<EnterNewAddressBloc, EnterNewAddressState>(
        builder: (context, state) => state is CreatingNewAddressState
            ? const CircularLoaderWidget()
            : Container(
                width: double.infinity,
                height: LayoutConstants.dimen_48.h,
                child: RaisedButton(
                  color: AppColor.primaryColor,
                  disabledColor: Colors.lightGreen,
                  onPressed: () =>
                      _validateFields ? _createNewAddress() : _showSnackbar(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Text(
                    'Save Address',
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
      );

  Container _getSelectedLocationContainer(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR LOCATION',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.primaryColor,
                  ),
            ),
            _getAddressContainer(context)
          ],
        ),
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
                'Splendid County, Lohegaon, Dhanori',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
}
