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
    yield UserProfileFetchingState();
    final user = await userProfileUseCase.fetchUserProfile();
    yield UserProfileFetchSuccessState(user: user);
  }

  Stream<UserProfileState> _handleSetupUserProfileEvent(
      SetupUserProfileEvent event) async* {
    yield UserProfileSettingUpState();
    await userProfileUseCase.setupUserProfile(event.user);
    yield UserProfileSetupSuccessState();
  }

  Stream<UserProfileState> _handleUpdateUserProfileEvent(
      UpdateUserProfileEvent event) async* {
    yield UserProfileUpdatingState();
    await userProfileUseCase.updateUserProfile(event.user);
    yield UserProfileUpdateSuccessState();
  }
}
