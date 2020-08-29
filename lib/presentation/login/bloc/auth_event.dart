import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthEvents { appStart, sendCode, resendCode, verifyPhoneNumber }

class AuthEvent {
  final String phoneNumber;

  AuthEvent(this.phoneNumber);
}

class VerifyPhoneNumberEvent extends AuthEvent {
  VerifyPhoneNumberEvent({
    @required String phoneNumber,
  }) : super(phoneNumber);
}

class VerifyPhoneNumberSuccessEvent extends AuthEvent {
  final AuthCredential authCredential;

  VerifyPhoneNumberSuccessEvent({
    @required String phoneNumber,
    @required this.authCredential,
  }) : super(phoneNumber);
}

class VerifyPhoneNumberFailedEvent extends AuthEvent {
  VerifyPhoneNumberFailedEvent({
    @required Exception exception,
  }) : super(null);
}

class AuthenticateWithSmsCodeEvent extends AuthEvent {
  final String smsCode;

  AuthenticateWithSmsCodeEvent({
    @required String phoneNumber,
    @required this.smsCode,
  }) : super(phoneNumber);
}
