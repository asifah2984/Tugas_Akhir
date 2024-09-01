import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/settings/domain/repos/settings_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdatePassword extends UseCaseWithParams<void, UpdatePasswordParams> {
  const UpdatePassword(this._repo);

  final SettingsRepo _repo;

  @override
  ResultFuture<void> call(UpdatePasswordParams params) {
    return _repo.updatePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      email: params.email,
    );
  }
}

class UpdatePasswordParams extends Equatable {
  const UpdatePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.email,
  });

  final String currentPassword;
  final String newPassword;
  final String email;

  @override
  List<Object?> get props => [currentPassword, newPassword, email];
}
