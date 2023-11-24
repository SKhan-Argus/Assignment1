import 'package:frontend_task1/models/user.dart';

abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;
  AuthenticatedState(this.user);
}

class UnauthenticatedState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String errorMessage;
  ErrorAuthState(this.errorMessage);
}
