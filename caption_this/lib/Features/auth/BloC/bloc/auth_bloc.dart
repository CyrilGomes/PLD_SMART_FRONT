import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginEvent>(_LoginEvent);
    on<AuthRegisterEvent>(_RegisterEvent);
  }

  _LoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository
        .attemptLogin(event.username, event.password)
        .then((token) {
      emit(AuthLoginSuccess(token: token));
      var storage = const FlutterSecureStorage();
      if (token != null) {
        storage.write(key: "jwt", value: token);
      }
    }).catchError((error) {
      emit(AuthError(message: error.toString()));
    });
  }

  _RegisterEvent(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository
        .attemptSignup(event.email, event.username, event.password)
        .then((success) {
      emit(AuthRegisterSuccess());
    }).catchError((error) {
      emit(AuthError(message: error.toString()));
    });
  }
}
