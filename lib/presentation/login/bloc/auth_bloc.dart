import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/assertion_constants.dart';
import 'package:aker_foods_retail/domain/entities/user_entity.dart';
import 'package:aker_foods_retail/domain/usecases/auth_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final AuthUseCase authUseCase;

  String _verificationId;

  AuthBloc({@required this.authUseCase})
      : assert(authUseCase != null, AssertionConstants.authUseCaseNotNull);

  @override
  AuthenticationState get initialState => AuthenticationInitialState();

  @override
  Stream<AuthenticationState> mapEventToState(AuthEvent event) async* {
    switch (event.runtimeType) {
      /*case AppStart:
        yield* mapAppStartToEvent();
        break;
      case SendCode:
        yield* mapSendCodeEvent(event);
        break;
      case ResendCode:
        yield* mapResendCodeEvent(event);
        break;
      case VerifyPhoneNumber:
        yield* mapVerifyPhoneNumberEvent(event);
        break;*/

      case VerifyPhoneNumberEvent:
        yield* mapVerifyPhoneNumberEvent(event);
        break;

      case VerifyPhoneNumberSuccessEvent:
        yield* mapVerifyPhoneNumberSuccessEvent(event);
        break;

      case VerifyPhoneNumberFailedEvent:
        yield* mapVerifyPhoneNumberFailedEvent(event);
        break;

      case AuthenticateWithSmsCodeEvent:
        yield* mapAuthenticateWithSmsCodeEvent(event);
        break;
    }
  }

  Stream<AuthenticationState> mapVerifyPhoneNumberEvent(
      VerifyPhoneNumberEvent event) async* {
    try {
      yield PhoneNumberVerificationStartedState(phoneNumber: event.phoneNumber);
      await _verifyPhoneNumber(event.phoneNumber);
    } catch (e) {
      yield PhoneNumberVerificationFailureState();
    }
  }

  Stream<AuthenticationState> mapVerifyPhoneNumberSuccessEvent(
      VerifyPhoneNumberSuccessEvent event) async* {
    try {
      yield AuthAutoVerificationStartedState(phoneNumber: event.phoneNumber);
      final user = await signInWithAuthCredential(event.authCredential);
      await authUseCase.saveUserAuthentication(user);
      yield AuthSuccessState(user: user);
    } catch (e) {
      yield AuthFailedState(phoneNumber: event.phoneNumber);
    }
  }

  Stream<AuthenticationState> mapVerifyPhoneNumberFailedEvent(
      VerifyPhoneNumberFailedEvent event) async* {
    yield PhoneNumberVerificationFailureState();
  }

  Stream<AuthenticationState> mapAuthenticateWithSmsCodeEvent(
      AuthenticateWithSmsCodeEvent event) async* {
    try {
      final authCredential = PhoneAuthProvider.credential(
          smsCode: event.smsCode, verificationId: _verificationId);
      final user = await signInWithAuthCredential(authCredential);
      await authUseCase.saveUserAuthentication(user);
      yield OtpVerificationSuccessState(user: user);

      final preferencesIdToken = await authUseCase.getUserAuthIdToken();
      final preferencesRefreshToken =
          await authUseCase.getUserAuthRefreshToken();
      debugPrint('OtpVerificationSuccessState PreferencesIdToken => '
          '$preferencesIdToken');
      debugPrint('OtpVerificationSuccessState PreferencesRefreshToken => '
          '$preferencesRefreshToken');
    } catch (e) {
      yield AuthFailedState(phoneNumber: event.phoneNumber);
    }
  }

  /*Stream<AuthState> mapAppStartToEvent() async* {
		try {
			final isAuthenticated = await authUsecase.isAuthenticated();
			if (isAuthenticated) {
				yield AuthenticatedState(user: await authUsecase.getUser());
			} else {
				yield UnAuthenticatedState();
			}
		} catch (_) {
			yield UnAuthenticatedState();
		}
	}

	Stream<AuthState> mapSendCodeEvent(SendCode event) async* {
		debugPrint('Bloc');
    await authUsecase.verifyPhoneNumber(event.phoneNumber);
    yield CodeSentState();
	}

	Stream<AuthState> mapResendCodeEvent(ResendCode event) async* {
		debugPrint('Bloc');
		await authUsecase.verifyPhoneNumber(event.phoneNumber);
		yield CodeSentState();
	}

	Stream<AuthState> mapVerifyPhoneNumberEvent(VerifyPhoneNumber event) async* {
		try {
			final _user = await authUsecase.signInWithSmsCode(event.smsCode);
			yield AuthenticatedState(user: _user);
		} catch (e) {
			yield UnAuthenticatedState();
		}
	}*/

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    debugPrint('_verifyPhoneNumber');
    debugPrint(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      timeout: AppConstants.firebaseAuthRequestTimeoutDuration,
      codeSent: _onSmsCodeSent,
      verificationFailed: _onVerificationFailed,
      verificationCompleted: _onVerificationComplete,
      codeAutoRetrievalTimeout: (verificationId) =>
          _verificationId = verificationId,
    );
  }

  Future<UserEntity> signInWithAuthCredential(
      AuthCredential authCredential) async {
    final user =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    final idToken = await user.user.getIdToken();
    return UserEntity(
      userId: user.user.uid,
      idToken: idToken,
      refreshToken: user.user.refreshToken,
      displayName: user.user.displayName,
      phoneNumber: user.user.phoneNumber,
    );
  }

  void _onVerificationComplete(AuthCredential authCredential) {
    add(VerifyPhoneNumberSuccessEvent(
      phoneNumber: state.phoneNumber,
      authCredential: authCredential,
    ));
  }

  void _onVerificationFailed(FirebaseAuthException authException) {
    add(VerifyPhoneNumberFailedEvent(exception: authException));
  }

  void _onSmsCodeSent(String verificationId, int code) {
    _verificationId = verificationId;
  }
}
