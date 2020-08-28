import 'package:aker_foods_retail/presentation/my_account/widgets/my_account_cell_item.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final cells = [
    MyAccountCellItem(
      icon: Icons.business,
      title: 'My Order',
    ),
    MyAccountCellItem(
      icon: Icons.credit_card,
      title: 'My Wallet',
      subtitle: 'Rs 1000',
    ),
    MyAccountCellItem(
      icon: Icons.question_answer,
      title: 'Support and FAQ',
    ),
    MyAccountCellItem(
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
        style: Theme.of(context).textTheme.headline6,
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, '/user-profile');
          },
        ),
      ],
    );
  }

  Container _getUserProfile(BuildContext context) {
    return Container(
      color: AppColor.textfieldPrefixIconColor,
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
            backgroundImage: const NetworkImage('https://picsum.photos/200'),
            radius: 70.w,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Mr Sumit Thakre',
            style: Theme.of(context).textTheme.headline5.apply(
                  color: AppColor.white,
                ),
          ),
          SizedBox(
            height: 12.w,
          ),
          _getLocationContainer(context)
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
          child: _getCell(cells[index]),
        ),
      ),
    );
  }

  Container _getLocationContainer(BuildContext context) {
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
      height: 50.h,
      child: Row(
        children: [
          Icon(
            Icons.add_location,
            color: AppColor.textfieldPrefixIconColor,
            size: 32.h,
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Something',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: FlatButton(
              onPressed: () => {},
              child: Text(
                'Change',
                style: Theme.of(context).textTheme.caption.apply(
                      color: AppColor.textfieldPrefixIconColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _getCell(MyAccountCellItem item) => Container(
        height: 60.h,
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: AppColor.textfieldPrefixIconColor,
              size: 32.h,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              flex: 2,
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.subtitle ?? '',
                style: Theme.of(context).textTheme.headline5.apply(
                      color: AppColor.orangeDark,
                    ),
                textAlign: TextAlign.end,
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
        debugPrint('Faq');
        break;
      case 3:
        debugPrint('logout');
        break;
    }
  }
}
