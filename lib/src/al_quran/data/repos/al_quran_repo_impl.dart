import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/errors/failures.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/datasources/al_quran_local_datasource.dart';
import 'package:alquran_app/src/al_quran/data/datasources/al_quran_remote_datasource.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AlQuranRepo)
class AlQuranRepoImpl implements AlQuranRepo {
  const AlQuranRepoImpl({
    required AlQuranRemoteDataSource remoteDataSource,
    required AlQuranLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AlQuranRemoteDataSource _remoteDataSource;
  final AlQuranLocalDataSource _localDataSource;

  @override
  ResultFuture<List<Surah>> getSurahs() async {
    try {
      final result = await _remoteDataSource.getSurahs();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<SurahDetail> getSurahDetail({
    required int number,
  }) async {
    try {
      final result = await _remoteDataSource.getSurahDetail(
        number: number,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Juz>> getJuzs() async {
    try {
      final cachedResult = await _localDataSource.getJuzs();

      if (cachedResult.isNotEmpty) {
        return Right(cachedResult);
      }

      final result = await _remoteDataSource.getJuzs();

      // ignore: avoid_function_literals_in_foreach_calls
      result.forEach(
        (result) async {
          await _localDataSource.insertJuz(result);
        },
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Juz> getJuz({
    required int juz,
  }) async {
    try {
      final result = await _localDataSource.getJuz(juz);

      return Right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Bookmark>> getBookmarks({
    required String userId,
  }) async {
    try {
      final result = await _localDataSource.getBookmarks(userId);

      return right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> createBookmark({
    required Bookmark bookmark,
  }) async {
    try {
      final result = await _localDataSource.insertBookmark(bookmark);

      return Right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteBookmark({
    required int id,
  }) async {
    try {
      final result = await _localDataSource.deleteBookmark(id);

      return Right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Bookmark?> getLastRead({
    required String userId,
  }) async {
    try {
      final result = await _localDataSource.getLastRead(userId);

      return Right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }
}
