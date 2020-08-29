import 'package:aker_foods_retail/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';

enum AuthStates {
  uninitializedState,
  authenticatedState,
  unAuthenticatedState,
  codeSentState,
  errorState
}

abstract class AuthenticationState {
  final String phoneNumber;

  AuthenticationState({this.phoneNumber});
}

class AuthenticationInitialState extends AuthenticationState {}

class PhoneNumberVerificationStartedState extends AuthenticationState {
  PhoneNumberVerificationStartedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class PhoneNumberVerificationSuccessState extends AuthenticationState {
  PhoneNumberVerificationSuccessState({
    UserEntity user,
  }) : super(phoneNumber: user.phoneNumber);
}

class PhoneNumberVerificationFailureState extends AuthenticationState {}

class AuthAutoVerificationStartedState extends AuthenticationState {
  AuthAutoVerificationStartedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class AuthFailedState extends AuthenticationState {
  AuthFailedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class AuthSuccessState extends AuthenticationState {
  final UserEntity user;

  AuthSuccessState({
    @required this.user,
  }) : super(phoneNumber: user.phoneNumber);
}

class OtpVerificationFailureState extends AuthenticationState {}

class OtpVerificationSuccessState extends AuthenticationState {
  final UserEntity user;

  OtpVerificationSuccessState({
    @required this.user,
  }) : super(phoneNumber: user.phoneNumber);
}

/*
abstract class AuthState extends Equatable {
  final AppUser user;

  dynamic name();

  AuthState({this.user});

  @override
  List<Object> get props => [];
}

class UninitializedState extends AuthState {
  @override
  AuthStates name() {
    return AuthStates.uninitializedState;
  }
}

class AuthenticatedState extends AuthState {
  AuthenticatedState({AppUser user}) : super(user: user);

  @override
  AuthStates name() {
    return AuthStates.authenticatedState;
  }
}

class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState();

  @override
  List<Object> get props => [];

  @override
  AuthStates name() {
    return AuthStates.unAuthenticatedState;
  }
}

/// This state is set in response to the event to send sms code to the user.
class CodeSentState extends AuthState {
  CodeSentState();

  @override
  List<Object> get props => [];

  @override
  AuthStates name() {
    return AuthStates.codeSentState;
  }
}
*/
