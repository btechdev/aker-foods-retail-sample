import 'package:flutter/material.dart';

import '../../../common/constants/layout_constants.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../../domain/entities/my_account_option_data_entity.dart';
import '../../../presentation/theme/app_colors.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Column(
        children: [
          _getUserProfile(context),
          _getSettings(),
        ],
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Account',
        style: Theme.of(context).textTheme.button,
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, '/edit-profile');
          },
        ),
      ],
    );
  }

  Container _getUserProfile(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 20.h,
        bottom: 4.h,
      ),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.w,
            backgroundImage:
                const ExactAssetImage('assets/images/user-profile-vegies.jpeg'),
          ),
          SizedBox(height: 16.h),
          Text(
            'Mr Full Name',
            style: Theme.of(context).textTheme.headline5.apply(
                  color: AppColor.white,
                ),
          ),
          SizedBox(height: 4.w),
          Text(
            'full-name@gmail.com',
            style: Theme.of(context).textTheme.caption.apply(
                  color: AppColor.white87,
                ),
          ),
          SizedBox(height: 8.h),
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
        itemCount: 4,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => {_navigateTo(index)},
          child: _getCell(options[index]),
        ),
      ),
    );
  }

  Container _getAddressContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      height: LayoutConstants.profileInputTextFieldHeight,
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
              onPressed: () => {},
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

  Container _getCell(MyAccountOptionDataEntity item) => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.myAccountOptionCellHeight,
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
}
