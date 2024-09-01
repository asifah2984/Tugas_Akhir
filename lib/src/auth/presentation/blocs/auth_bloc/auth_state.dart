part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.registeringUser() = _RegisteringUser;

  const factory AuthState.userRegistered() = _UserRegistered;

  const factory AuthState.userRegistrationFailed({
    required String message,
  }) = _UserRegistrationFailed;

  const factory AuthState.loggingInUser() = _LoggingInUser;

  const factory AuthState.userLoggedIn({
    required LocalUser user,
  }) = _UserLoggedIn;

  const factory AuthState.userLoginFailed({
    required String message,
  }) = _UserLoginFailed;

  const factory AuthState.sendingPasswordResetEmail() =
      _SendingPasswordResetEmail;

  const factory AuthState.passwordResetEmailSent() = _PasswordResetEmailSent;

  const factory AuthState.sendPasswordResetEmailFailed({
    required String message,
  }) = _SendPasswordResetEmailFailed;

  const factory AuthState.loggingOutUser() = _LoggingOutUser;

  const factory AuthState.userLoggedOut() = _UserLoggedOut;

  const factory AuthState.userLogoutFailed({
    required String message,
  }) = _UserLogoutFailed;

  const factory AuthState.gettingUser() = _GettingUser;

  const factory AuthState.userLoaded({
    required LocalUser user,
  }) = _UserLoaded;

  const factory AuthState.getUserFailed({
    required String message,
  }) = _GetUserFailed;
}
