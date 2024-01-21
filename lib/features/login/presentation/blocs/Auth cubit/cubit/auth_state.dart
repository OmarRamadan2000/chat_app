part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  final String uId;

  AuthState({required this.uId});
}

final class AuthInitial extends AuthState {
  AuthInitial({required super.uId});
}

final class SignInLoding extends AuthState {
  SignInLoding({required super.uId});
}

final class SignInErorr extends AuthState {
  final String errMessage;

  SignInErorr({required this.errMessage, required super.uId});
}

final class SignInSuccess extends AuthState {
  final UserCredential userCredential;

  SignInSuccess({required this.userCredential, required super.uId});
}

final class SignUpLoding extends AuthState {
  SignUpLoding({required super.uId});
}

final class SignUpErorr extends AuthState {
  final String errMessage;

  SignUpErorr({required this.errMessage, required super.uId});
}

final class SignUpSuccess extends AuthState {
  final UserCredential userCredential;

  SignUpSuccess({required this.userCredential, required super.uId});
}

final class CreateUserLoding extends AuthState {
  CreateUserLoding({required super.uId});
}

final class CreateUserErorr extends AuthState {
  final String errMessage;

  CreateUserErorr({required this.errMessage, required super.uId});
}

final class CreateUserSuccess extends AuthState {
  CreateUserSuccess({required super.uId});
}
