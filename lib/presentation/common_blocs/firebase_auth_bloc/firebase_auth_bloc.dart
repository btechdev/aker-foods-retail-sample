import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/assertion_constants.dart';
import 'package:aker_foods_retail/domain/entities/firebase_auth_entity.dart';
import 'package:aker_foods_retail/domain/usecases/authentication_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_auth_event.dart';
import 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  final AuthenticationUseCase authUseCase;

  String _verificationId;

  FirebaseAuthBloc({@required this.authUseCase})
      : assert(authUseCase != null, AssertionConstants.authUseCaseNotNull),
        super(FirebaseAuthInitialState());

  @override
  Stream<FirebaseAuthState> mapEventToState(FirebaseAuthEvent event) async* {
    switch (event.runtimeType) {
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

  Stream<FirebaseAuthState> mapVerifyPhoneNumberEvent(
      VerifyPhoneNumberEvent event) async* {
    try {
      yield PhoneNumberVerificationStartedState(phoneNumber: event.phoneNumber);
      await _verifyPhoneNumber(event.phoneNumber);
    } catch (e) {
      debugPrint('FirebaseAuthBloc => ${e.message}');
      debugPrint(e);
      yield PhoneNumberVerificationFailureState();
    }
  }

  Stream<FirebaseAuthState> mapVerifyPhoneNumberSuccessEvent(
      VerifyPhoneNumberSuccessEvent event) async* {
    try {
      yield AuthAutoVerificationStartedState(phoneNumber: event.phoneNumber);
      final user = await signInWithAuthCredential(event.authCredential);
      await authUseCase.saveUserAuthentication(user);
      yield AuthSuccessState(user: user);
      debugPrint('AuthSuccessState IdToken => ''${user.idToken}');
    } catch (e) {
      debugPrint('FirebaseAuthBloc => ${e.message}');
      debugPrint(e);
      yield AuthFailedState(phoneNumber: event.phoneNumber);
    }
  }

  Stream<FirebaseAuthState> mapVerifyPhoneNumberFailedEvent(
      VerifyPhoneNumberFailedEvent event) async* {
    yield PhoneNumberVerificationFailureState();
  }

  Stream<FirebaseAuthState> mapAuthenticateWithSmsCodeEvent(
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
      debugPrint('FirebaseAuthBloc => ${e.message}');
      debugPrint(e);
      yield AuthFailedState(phoneNumber: event.phoneNumber);
    }
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
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

  Future<FirebaseAuthEntity> signInWithAuthCredential(
      AuthCredential authCredential) async {
    final user =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    final idToken = await user.user.getIdToken();
    return FirebaseAuthEntity(
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
    debugPrint('FirebaseAuthBloc => ${authException.message}');
    add(VerifyPhoneNumberFailedEvent(exception: authException));
  }

  void _onSmsCodeSent(String verificationId, int code) {
    _verificationId = verificationId;
  }
}
