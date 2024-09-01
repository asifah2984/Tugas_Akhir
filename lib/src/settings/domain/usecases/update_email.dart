import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/settings/domain/repos/settings_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateEmail extends UseCaseWithParams<void, UpdateEmailParams> {
  const UpdateEmail(this._repo);

  final SettingsRepo _repo;

  @override
  ResultFuture<void> call(UpdateEmailParams params) {
    return _repo.updateEmail(
      currentEmail: params.currentEmail,
      newEmail: params.newEmail,
      password: params.password,
    );
  }
}

class UpdateEmailParams extends Equatable {
  const UpdateEmailParams({
    required this.currentEmail,
    required this.newEmail,
    required this.password,
  });

  final String currentEmail;
  final String newEmail;
  final String password;

  @override
  List<Object?> get props => [newEmail];
}
