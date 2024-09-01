import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/entities/user.dart';
import 'package:alquran_app/src/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUser extends UseCaseWithoutParams<LocalUser> {
  const GetUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call() {
    return _repo.getUser();
  }
}
