import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:aker_foods_retail/presentation/widgets/profile_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfileModel user;

  EditProfileScreen({@required this.user});

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<EditProfileScreen> {
  final _listOfSalutations = ['Mr', 'Mrs', 'Miss'];
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
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

  UserProfileModel get createUser => UserProfileModel(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        salutation: dropdownValue,
      );

  void _setupUserProfile() {
    userProfileBloc.add(
      UpdateUserProfileEvent(
        user: createUser,
      ),
    );
  }

  void _checkState(BuildContext context, UserProfileState state) {
    if (state is UserProfileUpdateSuccessState) {
      Navigator.pop(context, state);
      Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
        text: 'User Profile updated',
        type: CustomSnackBarType.success,
        position: CustomSnackBarPosition.top,
      ));
    } else if (state is UserProfileUpdateFailedState) {
      Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
        text: state.errorMessage,
        type: CustomSnackBarType.error,
        position: CustomSnackBarPosition.top,
      ));
    } else {}
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    dropdownValue = widget.user.salutation;
    userProfileBloc = Injector.resolve<UserProfileBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileBloc>(
      create: (context) => userProfileBloc,
      child: Scaffold(
        appBar: _getAppBar(),
        body: KeyboardAvoider(
          autoScroll: true,
          child: _getBodyWrappedWithBloc(),
        ),
      ),
    );
  }

  BlocListener<UserProfileBloc, UserProfileState> _getBodyWrappedWithBloc() =>
      BlocListener<UserProfileBloc, UserProfileState>(
        listener: _checkState,
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: _getBody,
        ),
      );

  AppBar _getAppBar() => AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          'Edit Profile',
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
              textInputType: TextInputType.emailAddress,
              prefixIcon: _textFieldPrefixIcon(Icons.email),
              controller: _emailController,
            ),
            _inputFieldsVerticalSpacing(),
            _phoneNumberContainer(),
            SizedBox(height: 24.h),
            _buttonWithContainer(state),
          ],
        ),
      );

  Icon _textFieldPrefixIcon(IconData data) => Icon(
        data,
        color: AppColor.primaryColor,
        size: LayoutConstants.dimen_30.w,
      );

  SizedBox _inputFieldsVerticalSpacing() =>
      SizedBox(height: LayoutConstants.dimen_20.h);

  Widget _buttonWithContainer(UserProfileState state) =>
      state is UserProfileUpdatingState
          ? const CircularLoaderWidget()
          : Container(
              width: double.infinity,
              height: LayoutConstants.dimen_48.h,
              child: RaisedButton(
                color: AppColor.primaryColor,
                disabledColor: Colors.lightGreen,
                onPressed: () =>
                    _validateInputFields() ? _setupUserProfile() : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Text(
                  'SAVE',
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ),
            );

  Container _salutationDropdownContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_52.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_12.w),
        decoration: LayoutConstants.inputBoxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _textFieldPrefixIcon(Icons.person),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: DropdownButtonHideUnderline(
                  child: _getDropDownButton(),
                ),
              ),
            ),
          ],
        ),
      );

  DropdownButton<String> _getDropDownButton() {
    return DropdownButton<String>(
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
      items: _listOfSalutations.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Container _phoneNumberContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_52.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_12.w),
        decoration: LayoutConstants.inputBoxDecoration,
        child: Row(
          children: [
            _textFieldPrefixIcon(Icons.phonelink_setup),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Text(
                '+91 **********',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColor.black54,
                    ),
              ),
            ),
          ],
        ),
      );
}
