import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/errors/failures.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/data/datasources/auth_local_datasource.dart';
import 'package:alquran_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:alquran_app/src/auth/domain/entities/user.dart';
import 'package:alquran_app/src/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  ResultFuture<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.registerUser(
        name: name,
        email: email,
        password: password,
      );

      await _localDataSource.setFirstTimer();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.loginUser(
        email: email,
        password: password,
      );

      await _localDataSource.setFirstTimer();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> resetPassword({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.resetPassword(email: email);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> logoutUser() async {
    try {
      final result = await _remoteDataSource.logoutUser();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> getUser() async {
    try {
      final result = await _remoteDataSource.getUser();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }
}
