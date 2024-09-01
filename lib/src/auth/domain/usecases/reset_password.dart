import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPassword extends UseCaseWithParams<void, ResetPasswordParams> {
  const ResetPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(ResetPasswordParams params) {
    return _repo.resetPassword(email: params.email);
  }
}

class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}
