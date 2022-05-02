part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class AuthLoginSuccess extends AuthState {
  AuthLoginSuccess({required String token});
}

class AuthLogoutSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthLoading extends AuthState {}
