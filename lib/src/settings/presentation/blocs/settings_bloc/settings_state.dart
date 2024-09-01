part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.settingsInitial() = SettingsInitial;

  const factory SettingsState.sendingUpdateEmailVerification() =
      SendingUpdateEmailVerification;

  const factory SettingsState.updateEmailVerificationSent() =
      UpdateEmailVerificationSent;

  const factory SettingsState.sendUpdateEmailVerificationFailed({
    required String message,
  }) = SendUpdateEmailVerificationFailed;

  const factory SettingsState.updatingPassword() = UpdatingPassword;

  const factory SettingsState.passwordUpdated() = PasswordUpdated;

  const factory SettingsState.updatePasswordFailed({
    required String message,
  }) = UpdatePasswordFailed;
}
