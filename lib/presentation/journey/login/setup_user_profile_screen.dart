import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../common/constants/layout_constants.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';
import '../../theme/app_colors.dart';
import '../../widgets/profile_text_field_widget.dart';

class SetupUserProfileScreen extends StatefulWidget {
  @override
  _SetupProfileScreen createState() => _SetupProfileScreen();
}

class _SetupProfileScreen extends State<SetupUserProfileScreen> {
  final _listOfSalutations = ['Mr', 'Miss'];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  String dropdownValue;
  UserProfileBloc userProfileBloc;

  bool _validateInputFields() {
    if (_firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _listOfSalutations.contains(dropdownValue)) {
      return true;
    } else {
      return false;
    }
  }

  UserProfileModel get userProfileModel => UserProfileModel(
        salutation: dropdownValue,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        referralCode: _referralCodeController.text.trim(),
      );

  void _setupUserProfile() {
    userProfileBloc.add(SetupUserProfileEvent(user: userProfileModel));
  }

  @override
  void initState() {
    super.initState();
    userProfileBloc = Injector.resolve<UserProfileBloc>();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<UserProfileBloc>(
        create: (context) => userProfileBloc,
        child: Scaffold(
          appBar: _getAppBar(),
          body: KeyboardAvoider(
            autoScroll: true,
            child: _getBodyWrappedWithBloc(),
          ),
        ),
      );

  BlocListener<UserProfileBloc, UserProfileState> _getBodyWrappedWithBloc() =>
      BlocListener<UserProfileBloc, UserProfileState>(
        listener: _checkState,
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: _getBody,
        ),
      );

  void _checkState(BuildContext context, UserProfileState state) {
    if (state is UserProfileSetupSuccessState) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteConstants.dashboard,
        (_) => false,
      );
      Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
        text: 'User Profile created',
        type: CustomSnackBarType.success,
        position: CustomSnackBarPosition.top,
      ));
    } else if (state is UserProfileSetupFailedState) {
      Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
        text: state.errorMessage,
        type: CustomSnackBarType.error,
      ));
    }
  }

  AppBar _getAppBar() => AppBar(
        elevation: LayoutConstants.appBarDefaultElevation,
        backgroundColor: AppColor.white,
        title: Text(
          'Profile Details',
          style: Theme.of(context).textTheme.button,
        ),
      );

  Container _getBody(BuildContext context, UserProfileState state) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _salutationDropdownContainer(),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'First Name',
              prefixIcon: _textFieldPrefixIcon(Icons.assignment_ind),
              controller: _firstNameController,
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Last Name',
              prefixIcon: _textFieldPrefixIcon(Icons.assignment),
              controller: _lastNameController,
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Email',
              prefixIcon: _textFieldPrefixIcon(Icons.email),
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            _inputFieldsVerticalSpacing(),
            ProfileTextFieldWidget(
              hintText: 'Referral Code (optional)',
              prefixIcon: _textFieldPrefixIcon(Icons.supervisor_account),
              controller: _referralCodeController,
            ),
            SizedBox(height: 24.h),
            _buttonWithContainer(context, state),
          ],
        ),
      );

  Icon _textFieldPrefixIcon(IconData data) => Icon(
        data,
        size: 30.w,
        color: AppColor.primaryColor,
      );

  SizedBox _inputFieldsVerticalSpacing() => SizedBox(height: 20.h);

  Widget _buttonWithContainer(BuildContext context, UserProfileState state) {
    if (state is UserProfileSettingUpState) {
      return const CircularLoaderWidget();
    } else {
      return Container(
        height: LayoutConstants.dimen_48.h,
        width: double.infinity,
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: () => _validateInputFields() ? _setupUserProfile() : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Text(
            'Create Profile'.toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );
    }
  }

  Container _salutationDropdownContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_52.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        decoration: LayoutConstants.inputBoxDecoration,
        child: Row(
          children: [
            _textFieldPrefixIcon(Icons.person),
            SizedBox(width: 8.w),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    hint: Text(
                      'Choose Title',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: AppColor.black54,
                          ),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24.w,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: _listOfSalutations
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
