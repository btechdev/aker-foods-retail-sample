import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_state.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDeliveryAddressSelection extends StatefulWidget {
  final void Function(int) onAddressSelection;

  OrderDeliveryAddressSelection({Key key, this.onAddressSelection})
      : super(key: key);

  @override
  _OrderDeliveryAddressSelectionState createState() =>
      _OrderDeliveryAddressSelectionState();
}

class _OrderDeliveryAddressSelectionState
    extends State<OrderDeliveryAddressSelection> {
  AddressModel _selectedAddress;
  ChangeAddressBloc changeAddressBloc;

  @override
  void initState() {
    super.initState();
    changeAddressBloc = Injector.resolve<ChangeAddressBloc>()
      ..add(FetchCurrentAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeAddressBloc>(
      create: (context) => changeAddressBloc,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getHeaderText(context),
                _chooseAddressButton(context),
                /*GestureDetector(
                  onTap: () => _getLocationSelectionBottomSheet(context),
                  child: Text(
                    'Choose Address',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )*/
              ],
            ),
            SizedBox(height: LayoutConstants.dimen_8.h),
            _selectedAddressTextBuilder(),
          ],
        ),
      ),
    );
  }

  Text _getHeaderText(BuildContext context) => Text(
        'Delivery Address',
        style: Theme.of(context).textTheme.headline6,
      );

  FlatButton _chooseAddressButton(BuildContext context) => FlatButton(
        onPressed: _getLocationSelectionBottomSheet,
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_8.w),
        child: Text(
          'Choose Address',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.black54,
              ),
        ),
      );

  Widget _selectedAddressTextBuilder() =>
      BlocBuilder<ChangeAddressBloc, ChangeAddressState>(
        builder: (context, state) {
          if (state is FetchSelectedAddressSuccessState) {
            _selectedAddress = state.addressModel;
            widget.onAddressSelection(_selectedAddress.id);
            return Row(
              children: [
                _addressLabelWidget(context),
                SizedBox(width: LayoutConstants.dimen_12.w),
                Expanded(
                  child: _addressText(),
                ),
              ],
            );
          } else {
            return const Text('');
          }
        },
      );

  Text _addressText() => Text(
        '${_selectedAddress.address1}'
        ' ${_selectedAddress.address2}',
        maxLines: 5,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: AppColor.primaryColor,
            ),
      );

  Widget _addressLabelWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: LayoutConstants.dimen_56.w,
      height: LayoutConstants.dimen_20.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_20.w),
      ),
      child: Text(
        _selectedAddress?.label ?? '',
        style: Theme.of(context).textTheme.overline.copyWith(
              color: AppColor.primaryColor,
            ),
      ),
    );
  }

  Future<void> _getLocationSelectionBottomSheet() async {
    final _ = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LayoutConstants.dimen_12.w),
          topRight: Radius.circular(LayoutConstants.dimen_12.w),
        ),
      ),
      builder: (BuildContext context) => ChangeAddressModeSelectionBottomSheet(
        onAddressChange: (address) {
          changeAddressBloc.add(FetchCurrentAddressEvent());
          widget.onAddressSelection(address.id);
          Navigator.pop(context);
        },
      ),
    );
  }
}
