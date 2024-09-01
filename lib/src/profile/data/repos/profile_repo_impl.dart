import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/errors/failures.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/profile/data/datasources/profile_remote_datasource.dart';
import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';
import 'package:alquran_app/src/profile/domain/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  const ProfileRepoImpl({
    required ProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<TajwidTestResult>> getTajwidTestResults() async {
    try {
      final result = await _remoteDataSource.getTajwidTestResults();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }
}
