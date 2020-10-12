import 'package:aker_foods_retail/domain/entities/firebase_auth_entity.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseAuthState {
  final String phoneNumber;

  FirebaseAuthState({this.phoneNumber});
}

class FirebaseAuthInitialState extends FirebaseAuthState {}

class PhoneNumberVerificationStartedState extends FirebaseAuthState {
  PhoneNumberVerificationStartedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class PhoneNumberVerificationSuccessState extends FirebaseAuthState {
  PhoneNumberVerificationSuccessState({
    FirebaseAuthEntity user,
  }) : super(phoneNumber: user.phoneNumber);
}

class PhoneNumberVerificationFailureState extends FirebaseAuthState {}

class AuthAutoVerificationStartedState extends FirebaseAuthState {
  AuthAutoVerificationStartedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class AuthFailedState extends FirebaseAuthState {
  AuthFailedState({
    @required String phoneNumber,
  }) : super(phoneNumber: phoneNumber);
}

class AuthSuccessState extends FirebaseAuthState {
  final FirebaseAuthEntity user;

  AuthSuccessState({
    @required this.user,
  }) : super(phoneNumber: user.phoneNumber);
}

class OtpVerifyingState extends FirebaseAuthState {}

class OtpVerificationFailureState extends FirebaseAuthState {}

class OtpVerificationSuccessState extends FirebaseAuthState {
  final FirebaseAuthEntity user;

  OtpVerificationSuccessState({
    @required this.user,
  }) : super(phoneNumber: user.phoneNumber);
}
