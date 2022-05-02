part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  AuthLoginEvent({required this.username, required this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;
  AuthRegisterEvent(
      {required this.email, required this.username, required this.password});
}
