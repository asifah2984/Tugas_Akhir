part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.registerUserEvent({
    required String name,
    required String email,
    required String password,
  }) = _RegisterUserEvent;

  const factory AuthEvent.loginUserEvent({
    required String email,
    required String password,
  }) = _LoginUserEvent;

  const factory AuthEvent.sendPasswordResetEmailEvent({
    required String email,
  }) = _SendPasswordResetEmailEvent;

  const factory AuthEvent.logoutUserEvent() = _LogoutUserEvent;

  const factory AuthEvent.getUserEvent() = _GetUserEvent;
}
