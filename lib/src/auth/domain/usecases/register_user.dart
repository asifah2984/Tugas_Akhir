import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterUser extends UseCaseWithParams<void, RegisterUserParams> {
  const RegisterUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(RegisterUserParams params) {
    return _repo.registerUser(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterUserParams extends Equatable {
  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}
