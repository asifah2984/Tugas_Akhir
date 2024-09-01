import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUser extends UseCaseWithoutParams<void> {
  const LogoutUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call() {
    return _repo.logoutUser();
  }
}
