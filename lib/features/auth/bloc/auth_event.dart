part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthStatusRequested extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpRequested(this.email, this.password, this.fullName);
}

class SignOutRequested extends AuthEvent {}
