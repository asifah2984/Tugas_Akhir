import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  ResultFuture<void> registerUser({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> loginUser({
    required String email,
    required String password,
  });

  ResultFuture<void> resetPassword({
    required String email,
  });

  ResultFuture<void> logoutUser();

  ResultFuture<LocalUser> getUser();
}
