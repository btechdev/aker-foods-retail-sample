import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthEvent {
  final String phoneNumber;

  FirebaseAuthEvent(this.phoneNumber);
}

class VerifyPhoneNumberEvent extends FirebaseAuthEvent {
  VerifyPhoneNumberEvent({
    @required String phoneNumber,
  }) : super(phoneNumber);
}

class VerifyPhoneNumberSuccessEvent extends FirebaseAuthEvent {
  final AuthCredential authCredential;

  VerifyPhoneNumberSuccessEvent({
    @required String phoneNumber,
    @required this.authCredential,
  }) : super(phoneNumber);
}

class VerifyPhoneNumberFailedEvent extends FirebaseAuthEvent {
  VerifyPhoneNumberFailedEvent({
    @required Exception exception,
  }) : super(null);
}

class AuthenticateWithSmsCodeEvent extends FirebaseAuthEvent {
  final String smsCode;

  AuthenticateWithSmsCodeEvent({
    @required String phoneNumber,
    @required this.smsCode,
  }) : super(phoneNumber);
}
