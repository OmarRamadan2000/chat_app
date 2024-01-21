import 'package:firebase_auth/firebase_auth.dart';

class Failure {
  final String message;

  Failure(this.message);
}

class FirebaseAuthExceptionHandler {
  static void handleException(FirebaseAuthMultiFactorException exception) {
    String errorCode = exception.code;

    switch (errorCode) {
      case 'email-already-in-use':
        print('Email is already in use. Please choose a different email.');
        break;
      case 'invalid-email':
        print('Invalid email format. Please provide a valid email.');
        break;
      case 'user-not-found':
        print('User not found. Please check your credentials.');
        break;
      case 'wrong-password':
        print('Incorrect password. Please check your credentials.');
        break;
      default:
        print('Firebase Authentication Error: $errorCode');
    }
  }
}
