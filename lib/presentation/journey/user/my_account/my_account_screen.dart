import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:aker_foods_retail/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/layout_constants.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../../../domain/entities/my_account_option_data_entity.dart';
import '../../../theme/app_colors.dart';
import '../address/change_address_mode_selection_bottom_sheet.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  UserProfileBloc userProfileBloc;

  final options = [
    MyAccountOptionDataEntity(
      icon: Icons.local_mall,
      title: 'My Orders',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.account_balance_wallet,
      title: 'My Wallet',
      subtitle: 'Rs 1000',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.location_city,
      title: 'My Addresses',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.question_answer,
      title: 'Support and FAQ',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.offline_pin,
      title: 'Logout',
    )
  ];

  List<String> savedAddresses;

  @override
  void initState() {
    super.initState();
    userProfileBloc = Injector.resolve<UserProfileBloc>()
      ..add(FetchUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) => BlocProvider<UserProfileBloc>(
        create: (context) => userProfileBloc,
        child: Scaffold(
          appBar: _getAppBar(context),
          body: Column(
            children: [
              _getUserProfileContainerWrappedWithBloc(),
              _getSettings(),
            ],
          ),
        ),
      );

  BlocBuilder<UserProfileBloc, UserProfileState>
      _getUserProfileContainerWrappedWithBloc() =>
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: _getUserProfile,
          );

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'My Account',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  Widget _getUserInfoWidget(UserProfileState state) =>
      state is UserProfileFetchingState
          ? _getLoadingContainer()
          : state is UserProfileFetchSuccessState
              ? _getUserDetailsContainer(context, state)
              : const EmptyStateWidget();

  Container _getLoadingContainer() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
      ),
    );
  }

  Container _getUserProfile(BuildContext context, UserProfileState state) {
    return Container(
      color: AppColor.primaryColor,
      padding: EdgeInsets.only(
        left: LayoutConstants.dimen_16.w,
        right: LayoutConstants.dimen_16.w,
        top: LayoutConstants.dimen_20.h,
        bottom: LayoutConstants.dimen_20.h,
      ),
      child: Column(
        children: [
          _getUserInfoWidget(state),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getAddressContainer(context)
        ],
      ),
    );
  }

  Expanded _getSettings() {
    return Expanded(
      flex: 1,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: AppColor.grey,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => {_navigateTo(index)},
          child: _getCell(
            options[index],
          ),
        ),
      ),
    );
  }

  Container _getAddressContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      height: LayoutConstants.dimen_52.h,
      child: Row(
        children: [
          Icon(
            Icons.edit_location,
            size: 30.h,
            color: AppColor.primaryColor,
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: Text(
              'Address',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () => {
                _getLocationSelectionBottomSheet(context),
              },
              child: Text(
                'Change',
                style: Theme.of(context).textTheme.caption.apply(
                      color: AppColor.primaryColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _getLocationSelectionBottomSheet(BuildContext context) {
    savedAddresses = List();
    for (int i = 0; i < 10; i++) {
      savedAddresses.add('Address ${i + 1}');
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
      ),
      builder: (BuildContext context) =>
          ChangeAddressModeSelectionBottomSheet(savedAddresses: savedAddresses),
    );
  }

  Container _getCell(MyAccountOptionDataEntity item) => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.dimen_60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: AppColor.primaryColor,
              size: 30.h,
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: Text(
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.subtitle ?? '',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColor.orangeDark,
                    ),
              ),
            )
          ],
        ),
      );

  void _navigateTo(int index) {
    switch (index) {
      case 0:
        debugPrint('My Orders');
        break;
      case 1:
        debugPrint('My Wallet');
        break;
      case 2:
        debugPrint('Support and FAQ');
        break;
      case 3:
        debugPrint('Logout');
        break;
    }
  }

  Column _getUserDetailsContainer(
      BuildContext context, UserProfileState state) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: LayoutConstants.dimen_20.w,
              height: LayoutConstants.dimen_120.w,
            ),
            CircleAvatar(
              radius: LayoutConstants.dimen_60.w,
              backgroundImage: const ExactAssetImage(
                  'assets/images/user-profile-vegies.jpeg'),
            ),
            Container(
              height: LayoutConstants.dimen_120.w,
              alignment: Alignment.topCenter,
              child: _getEditUserInfoButton(),
            ),
          ],
        ),
        SizedBox(height: LayoutConstants.dimen_16.h),
        _getUserInfoColumn(state),
      ],
    );
  }

  Column _getUserInfoColumn(UserProfileFetchSuccessState state) => Column(
        children: [
          Text(
            '${state.user.salutation} '
            '${state.user.firstName} ${state.user.lastName}',
            style: Theme.of(context).textTheme.headline5.apply(
                  color: AppColor.white,
                ),
          ),
          SizedBox(height: LayoutConstants.dimen_4.h),
          Text(
            '${state.user.email}',
            style: Theme.of(context).textTheme.caption.apply(
                  color: AppColor.white87,
                ),
          ),
        ],
      );

  Widget _getEditUserInfoButton() => IconButton(
        icon: Icon(
          Icons.edit,
          color: AppColor.white,
          size: LayoutConstants.dimen_20.w,
        ),
        onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
      );
}
