import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:aker_foods_retail/domain/entities/my_account_option_data_entity.dart';
import 'package:aker_foods_retail/domain/entities/referral_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:aker_foods_retail/presentation/journey/user/edit_profile/edit_profile_screen.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/wallet_transactions_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  UserProfileBloc userProfileBloc;

  double currentBalance = 0.0;
  ReferralEntity referralEntity;

  final options = [
    MyAccountOptionDataEntity(
      icon: Icons.local_mall,
      title: 'My Orders',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.account_balance_wallet,
      title: 'My Wallet',
      subtitle: '${AppConstants.rupeeSymbol} 0',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.code,
      title: 'Referral',
    ),
    MyAccountOptionDataEntity(
      icon: Icons.offline_pin,
      title: 'Logout',
    )
  ];

  List<AddressModel> savedAddresses;

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Account Screen');
    userProfileBloc = Injector.resolve<UserProfileBloc>()
      ..add(FetchUserProfileEvent());
  }

  void _userProfileBlocListener(BuildContext context, UserProfileState state) {
    if (state is UserLoggedOutState) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteConstants.enterPhoneNumber,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider<UserProfileBloc>(
        create: (context) => userProfileBloc,
        child: Scaffold(
          appBar: _getAppBar(context),
          body: BlocListener<UserProfileBloc, UserProfileState>(
            listener: _userProfileBlocListener,
            child: _bodyWrappedWithBloc(),
          ),
        ),
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

  Widget _bodyWrappedWithBloc() =>
      BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserLoggingOutState) {
            return const CircularLoaderWidget();
          }
          if (state is UserProfileFetchSuccessState) {
            currentBalance = state.user.currentBalance;
            referralEntity = state.user.referral;
          }
          return Column(
            children: [
              _getUserProfile(context, state),
              _getSettings(),
            ],
          );
        },
      );

  Widget _getUserInfoWidget(UserProfileState state) =>
      state is UserProfileFetchingState
          ? _getLoadingContainer()
          : state is UserProfileFetchSuccessState
              ? _getUserDetailsContainer(context, state)
              : const EmptyStateWidget();

  Container _getLoadingContainer() {
    return Container(
      height: LayoutConstants.dimen_200.h,
      alignment: Alignment.center,
      child: const CircularLoaderWidget(),
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
          state is UserProfileFetchSuccessState
              ? _getAddressContainer(context, state.address)
              : _getAddressContainer(context, null)
        ],
      ),
    );
  }

  Expanded _getSettings() => Expanded(
        flex: 1,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: AppColor.grey,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => {_navigateTo(index)},
            child: (index == 1)
                ? _getCell(
                    MyAccountOptionDataEntity(
                        icon: Icons.account_balance_wallet,
                        title: 'My Wallet',
                        subtitle:
                            '${AppConstants.rupeeSymbol} $currentBalance'),
                  )
                : _getCell(
                    options[index],
                  ),
          ),
        ),
      );

  Container _getAddressContainer(BuildContext context, AddressEntity address) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_10.w),
        ),
        height: LayoutConstants.dimen_52.h,
        child: Row(
          children: [
            Icon(
              Icons.edit_location,
              size: LayoutConstants.dimen_32.h,
              color: AppColor.primaryColor,
            ),
            SizedBox(width: LayoutConstants.dimen_4.w),
            Expanded(
              flex: 2,
              child: Text(
                address == null ? 'Address' : address.address1,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: () => _getLocationSelectionBottomSheet(context),
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

  Future<void> _getLocationSelectionBottomSheet(BuildContext context) async {
    final status = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
      ),
      builder: (BuildContext context) => ChangeAddressModeSelectionBottomSheet(
        onAddressChange: (address) {
          userProfileBloc.add(UserAddressFetchEvent());
          Navigator.pop(context);
        },
      ),
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
        Navigator.pushNamed(context, RouteConstants.myOrders);
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletTransactionsScreen(
              currentWalletBalance: currentBalance,
            ),
          ),
        );
        break;
      case 2:
        Navigator.pushNamed(
          context,
          RouteConstants.referral,
          arguments: referralEntity,
        );
        break;
      case 3:
        _showConfirmLogoutDialog();
        break;
    }
  }

  Future<void> _showConfirmLogoutDialog() async => showDialog(
        context: context,
        child: AlertDialog(
          title: Text(
            'Do you want to logout this application?',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text(
            'We hate to see you leave',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No', style: Theme.of(context).textTheme.bodyText1),
            ),
            FlatButton(
              onPressed: () {
                AnalyticsUtil.trackEvent(eventName: 'Logout button clicked');
                Navigator.pop(context);
                userProfileBloc.add(LogoutUserEvent());
              },
              child: Text('Yes', style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      );

  Container _getUserDetailsContainer(
      BuildContext context, UserProfileFetchSuccessState state) {
    return Container(
      height: LayoutConstants.dimen_200.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userProfileImageWithEditButton(state),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _userFullNameText(context, state),
          SizedBox(height: LayoutConstants.dimen_4.h),
          _userEmailText(context, state),
        ],
      ),
    );
  }

  Row _userProfileImageWithEditButton(UserProfileState state) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: LayoutConstants.dimen_60.w,
                backgroundImage: const ExactAssetImage(
                    'assets/images/user-profile-vegies.jpeg'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: LayoutConstants.dimen_120.w,
              alignment: Alignment.topRight,
              child: _getEditUserInfoButton(state),
            ),
          ),
        ],
      );

  Text _userFullNameText(
    BuildContext context,
    UserProfileFetchSuccessState state,
  ) =>
      Text(
        '${state.user.salutation} '
        '${state.user.firstName} ${state.user.lastName}',
        style: Theme.of(context).textTheme.headline5.apply(
              color: AppColor.white,
            ),
      );

  Text _userEmailText(
    BuildContext context,
    UserProfileFetchSuccessState state,
  ) =>
      Text(
        '${state.user.email}',
        style: Theme.of(context).textTheme.caption.apply(
              color: AppColor.white87,
            ),
      );

  Widget _getEditUserInfoButton(UserProfileFetchSuccessState state) =>
      IconButton(
        icon: Icon(
          Icons.edit,
          color: AppColor.white,
          size: LayoutConstants.dimen_20.w,
        ),
        onPressed: () => _navigateToEditProfile(state),
      );

  Future<void> _navigateToEditProfile(
      UserProfileFetchSuccessState state) async {
    final incomingState = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: state.user),
      ),
    );

    if (incomingState is UserProfileUpdateSuccessState) {
      userProfileBloc.add(FetchUserProfileEvent());
    }
  }
}
