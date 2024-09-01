part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.sendUpdateEmailVerificationEvent({
    required String currentEmail,
    required String newEmail,
    required String password,
  }) = SendUpdateEmailVerificationEvent;

  const factory SettingsEvent.updatePasswordEvent({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) = UpdatePasswordEvent;
}
