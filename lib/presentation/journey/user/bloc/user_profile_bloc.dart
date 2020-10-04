import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/exceptions/server_exception.dart';
import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_profile_user_case.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileUseCase userProfileUseCase;
  final CartUseCase cartUseCase;

  UserProfileBloc({
    this.userProfileUseCase,
    this.cartUseCase,
  }) : super(EmptyState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserProfileEvent) {
      yield* _handleFetchUserProfileEvent();
    } else if (event is SetupUserProfileEvent) {
      yield* _handleSetupUserProfileEvent(event);
    } else if (event is UpdateUserProfileEvent) {
      yield* _handleUpdateUserProfileEvent(event);
    } else if (event is LogoutUserEvent) {
      yield* _handleLogoutUserEvent();
    }
  }

  Stream<UserProfileState> _handleFetchUserProfileEvent() async* {
    try {
      yield UserProfileFetchingState();
      final user = await userProfileUseCase.fetchUserProfile();
      yield UserProfileFetchSuccessState(user: user);
    } catch (e) {
      final message =
          e is ServerException ? e.message : AppConstants.unknownError;
      yield UserProfileFetchFailedState(errorMessage: message);
    }
  }

  Stream<UserProfileState> _handleSetupUserProfileEvent(
      SetupUserProfileEvent event) async* {
    try {
      yield UserProfileSettingUpState();
      await userProfileUseCase.setupUserProfile(event.user);
      await userProfileUseCase.setUserHasSetupProfileFlag(true);
      yield UserProfileSetupSuccessState();
    } catch (e) {
      final message =
          e is ServerException ? e.message : AppConstants.unknownError;
      yield UserProfileSetupFailedState(errorMessage: message);
    }
  }

  Stream<UserProfileState> _handleUpdateUserProfileEvent(
      UpdateUserProfileEvent event) async* {
    try {
      yield UserProfileUpdatingState();
      await userProfileUseCase.updateUserProfile(event.user);
      yield UserProfileUpdateSuccessState();
    } catch (e) {
      final message =
          e is ServerException ? e.message : AppConstants.unknownError;
      yield UserProfileUpdateFailedState(errorMessage: message);
    }
  }

  Stream<UserProfileState> _handleLogoutUserEvent() async* {
    debugPrint('Handling logout user event');
    try {
      debugPrint('Logging out from Firebase');
      await FirebaseAuth.instance.signOut();
    } catch (_) {}

    try {
      yield UserLoggingOutState();
      await cartUseCase.clearCart();
      final result = await userProfileUseCase.clearLocalPreferences();
      debugPrint('Logout user result: $result');
    } catch (_) {}

    debugPrint('Yielding UserLoggedOutState');
    yield UserLoggedOutState();
  }
}
