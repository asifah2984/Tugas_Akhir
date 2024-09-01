import 'package:alquran_app/src/auth/domain/entities/user.dart';
import 'package:alquran_app/src/auth/domain/usecases/get_user.dart';
import 'package:alquran_app/src/auth/domain/usecases/login_user.dart';
import 'package:alquran_app/src/auth/domain/usecases/logout_user.dart';
import 'package:alquran_app/src/auth/domain/usecases/register_user.dart';
import 'package:alquran_app/src/auth/domain/usecases/reset_password.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RegisterUser registerUser,
    required LoginUser loginUser,
    required ResetPassword resetPassword,
    required LogoutUser logoutUser,
    required GetUser getUser,
  })  : _registerUser = registerUser,
        _loginUser = loginUser,
        _resetPassword = resetPassword,
        _logoutUser = logoutUser,
        _getUser = getUser,
        super(const _Initial()) {
    on<_RegisterUserEvent>(_registerUserHandler);
    on<_LoginUserEvent>(_loginUserHandler);
    on<_SendPasswordResetEmailEvent>(_sendPasswordResetEmailHandler);
    on<_LogoutUserEvent>(_logoutUserHandler);
    on<_GetUserEvent>(_getUserHandler);
  }

  final RegisterUser _registerUser;
  final LoginUser _loginUser;
  final ResetPassword _resetPassword;
  final LogoutUser _logoutUser;
  final GetUser _getUser;

  Future<void> _registerUserHandler(
    _RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const _RegisteringUser());

    final result = await _registerUser(
      RegisterUserParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_UserRegistrationFailed(message: failure.errorMessage)),
      (_) => emit(const _UserRegistered()),
    );
  }

  Future<void> _loginUserHandler(
    _LoginUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const _LoggingInUser());

    final result = await _loginUser(
      LoginUserParams(
        email: event.email,
        password: event.password,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_UserLoginFailed(message: failure.errorMessage)),
      (user) => emit(_UserLoggedIn(user: user)),
    );
  }

  Future<void> _sendPasswordResetEmailHandler(
    _SendPasswordResetEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const _SendingPasswordResetEmail());

    final result = await _resetPassword(
      ResetPasswordParams(email: event.email),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(_SendPasswordResetEmailFailed(message: failure.errorMessage)),
      (_) => emit(const _PasswordResetEmailSent()),
    );
  }

  Future<void> _logoutUserHandler(
    _LogoutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const _LoggingOutUser());

    final result = await _logoutUser();

    if (isClosed) return;

    result.fold(
      (failure) => emit(_UserLogoutFailed(message: failure.errorMessage)),
      (user) => emit(const _UserLoggedOut()),
    );
  }

  Future<void> _getUserHandler(
    _GetUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const _GettingUser());

    final result = await _getUser();

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetUserFailed(message: failure.errorMessage)),
      (user) => emit(_UserLoaded(user: user)),
    );
  }
}
