import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChangeAddressScreen extends StatelessWidget {
  final ScrollController scrollController;
  final List<AddressModel> savedAddresses;
  final AddressModel currentAddress;
  final Function onSearchTapped;
  final Function onAddressTypeSelection;
  final Function onSelectAddress;

  final titles = ['Use current location', 'Add address'];
  final icons = [Icons.navigation, Icons.add];

  ChangeAddressScreen({
    this.scrollController,
    this.savedAddresses,
    this.onSearchTapped,
    this.onAddressTypeSelection,
    this.currentAddress,
    this.onSelectAddress,
  });

  /*@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
        vertical: LayoutConstants.dimen_16.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getHeader(context),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getSearchPlaceholderButton(context),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getLocationTypeList(),
          SizedBox(height: LayoutConstants.dimen_16.h),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
        vertical: LayoutConstants.dimen_16.h,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        itemCount: (savedAddresses?.length ?? 0) + 7,
        itemBuilder: _getListItem,
      ),
    );
  }

  Widget _getListItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _getHeader(context);

      case 1:
      case 3:
        return SizedBox(height: LayoutConstants.dimen_8.h);

      case 2:
        return _getSearchPlaceholderButton(context);

      case 4:
        return _addressModeSelectionListItem(context, 0);
      case 5:
        return const Divider(
          color: AppColor.grey,
        );

      case 6:
        return _addressModeSelectionListItem(context, 1);

      default:
        return ListTile(
          title: Text(savedAddresses[index - 7].address1),
          subtitle: Text(savedAddresses[index - 7].address2),
          trailing: _getTrailing(index),
          onTap: () {
            onSelectAddress(savedAddresses[index - 7]);
          },
        );
    }
  }

  Widget _getTrailing(int index) {
    if (savedAddresses.isNotEmpty && currentAddress != null) {
      if (savedAddresses[index - 7].id == currentAddress.id) {
        return const Icon(
          Icons.check,
          color: AppColor.primaryColor,
        );
      } else {
        return const Icon(
          Icons.check,
          color: AppColor.transparent,
        );
      }
    } else {
      return const Icon(
        Icons.check,
        color: AppColor.transparent,
      );
    }
  }

  Row _getHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Search Location',
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

  RaisedButton _getSearchPlaceholderButton(BuildContext context) =>
      RaisedButton(
        color: AppColor.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
        ),
        onPressed: onSearchTapped,
        child: _getSearchContainer(context),
      );

  Container _getSearchContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        height: LayoutConstants.dimen_52.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: AppColor.black40,
              size: LayoutConstants.dimen_30.w,
            ),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Text(
              'Search',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: AppColor.black40,
                  ),
            ),
          ],
        ),
      );

  /*Expanded _getLocationTypeList() => Expanded(
        child: _getLocationTypeListView(),
      );

  ListView _getLocationTypeListView() => ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(color: AppColor.grey),
        itemCount: titles.length,
        itemBuilder: _addressModeSelectionListItem,
      );*/

  Widget _addressModeSelectionListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => onAddressTypeSelection(index),
      child: _getCell(context, titles[index], icons[index]),
    );
  }

  Container _getCell(BuildContext context, String title, IconData icon) =>
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.dimen_48.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColor.primaryColor,
              size: LayoutConstants.dimen_30.h,
            ),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColor.primaryColor,
                    ),
              ),
            ),
          ],
        ),
      );
}
