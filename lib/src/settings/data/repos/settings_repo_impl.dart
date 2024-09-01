import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/errors/failures.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/settings/data/datasources/settings_remote_datasource.dart';
import 'package:alquran_app/src/settings/domain/repos/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepo)
class SettingsRepoImpl implements SettingsRepo {
  const SettingsRepoImpl({
    required SettingsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final SettingsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> updateEmail({
    required String currentEmail,
    required String newEmail,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.updateEmail(
        currentEmail: currentEmail,
        newEmail: newEmail,
        password: password,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        email: email,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }
}
