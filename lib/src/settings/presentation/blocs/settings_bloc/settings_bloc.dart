import 'package:alquran_app/src/settings/domain/usecases/update_email.dart';
import 'package:alquran_app/src/settings/domain/usecases/update_password.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required UpdateEmail updateEmail,
    required UpdatePassword updatePassword,
  })  : _updateEmail = updateEmail,
        _updatePassword = updatePassword,
        super(const SettingsInitial()) {
    on<SendUpdateEmailVerificationEvent>(_sendUpdateEmailVerificationHandler);
    on<UpdatePasswordEvent>(_updatePasswordHandler);
  }

  final UpdateEmail _updateEmail;
  final UpdatePassword _updatePassword;

  Future<void> _sendUpdateEmailVerificationHandler(
    SendUpdateEmailVerificationEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SendingUpdateEmailVerification());

    final result = await _updateEmail(
      UpdateEmailParams(
        currentEmail: event.currentEmail,
        newEmail: event.newEmail,
        password: event.password,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        SendUpdateEmailVerificationFailed(message: failure.errorMessage),
      ),
      (_) => emit(const UpdateEmailVerificationSent()),
    );
  }

  Future<void> _updatePasswordHandler(
    UpdatePasswordEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const UpdatingPassword());

    final result = await _updatePassword(
      UpdatePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        email: event.email,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        UpdatePasswordFailed(message: failure.errorMessage),
      ),
      (_) => emit(const PasswordUpdated()),
    );
  }
}
