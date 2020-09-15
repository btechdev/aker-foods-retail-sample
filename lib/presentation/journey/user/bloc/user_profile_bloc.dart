import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/exceptions/server_exception.dart';
import 'package:aker_foods_retail/domain/usecases/user_profile_user_case.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_event.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileUseCase userProfileUseCase;

  UserProfileBloc({this.userProfileUseCase}) : super(EmptyState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserProfileEvent) {
      yield* _handleFetchUserProfileEvent();
    } else if (event is SetupUserProfileEvent) {
      yield* _handleSetupUserProfileEvent(event);
    } else if (event is UpdateUserProfileEvent) {
      yield* _handleUpdateUserProfileEvent(event);
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
}
