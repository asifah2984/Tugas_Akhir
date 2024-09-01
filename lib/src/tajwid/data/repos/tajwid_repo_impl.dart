import 'dart:io';

import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/errors/failures.dart';
import 'package:alquran_app/core/utils/pair.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/data/datasources/tajwid_local_datasource.dart';
import 'package:alquran_app/src/tajwid/data/datasources/tajwid_remote_datasource.dart';
import 'package:alquran_app/src/tajwid/data/models/tajwid_question_model.dart';
import 'package:alquran_app/src/tajwid/data/models/test_response_model.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_response.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_result.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TajwidRepo)
class TajwidRepoImpl implements TajwidRepo {
  const TajwidRepoImpl({
    required TajwidRemoteDataSource remoteDataSource,
    required TajwidLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final TajwidRemoteDataSource _remoteDataSource;
  final TajwidLocalDataSource _localDataSource;

  @override
  ResultFuture<List<Tajwid>> getTajwids() async {
    try {
      final result = await _remoteDataSource.getTajwids();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<File?> pickThumbnailImage() async {
    try {
      final result = await _localDataSource.pickThumbnailImage();

      return Right(result);
    } on ClientException catch (e) {
      return Left(ClientFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addTajwid({
    required String tajwidName,
    required File thumbnailImage,
    required String tajwidDescription,
  }) async {
    try {
      final result = await _remoteDataSource.addTajwid(
        tajwidName: tajwidName,
        tajwidDescription: tajwidDescription,
        thumbnailImage: thumbnailImage,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> editTajwid({
    required String id,
    required String? newTajwidName,
    required String? newTajwidDescription,
    required File? newThumbnailImage,
  }) async {
    try {
      final result = await _remoteDataSource.editTajwid(
        id: id,
        newTajwidDescription: newTajwidDescription,
        newTajwidName: newTajwidName,
        newThumbnailImage: newThumbnailImage,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTajwid({
    required String id,
  }) async {
    try {
      final result = await _remoteDataSource.deleteTajwid(
        id: id,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TajwidMaterial>> getTajwidMaterials({
    required String tajwidId,
  }) async {
    try {
      final result = await _remoteDataSource.getTajwidMaterials(
        tajwidId: tajwidId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addTajwidMaterial({
    required String tajwidId,
    required String content,
  }) async {
    try {
      final result = await _remoteDataSource.addTajwidMaterial(
        tajwidId: tajwidId,
        content: content,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> editTajwidMaterial({
    required String id,
    required String newContent,
  }) async {
    try {
      final result = await _remoteDataSource.editTajwidMaterial(
        id: id,
        newContent: newContent,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTajwidMaterial({
    required String id,
  }) async {
    try {
      final result = await _remoteDataSource.deleteTajwidMaterial(id: id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TajwidQuestion>> getTajwidQuestions({
    required String tajwidId,
  }) async {
    try {
      final result = await _remoteDataSource.getTajwidQuestions(
        tajwidId: tajwidId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addTajwidQuestion({
    required String tajwidId,
    required String question,
    required List<String> choices,
    required String answer,
  }) async {
    try {
      final result = await _remoteDataSource.addTajwidQuestion(
        tajwidId: tajwidId,
        question: question,
        choices: choices,
        answer: answer,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> editTajwidQuestion({
    required String id,
    required String newQuestion,
    required List<String> newChoices,
    required String newAnswer,
  }) async {
    try {
      final result = await _remoteDataSource.editTajwidQuestion(
        id: id,
        newQuestion: newQuestion,
        newChoices: newChoices,
        newAnswer: newAnswer,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTajwidQuestion({
    required String id,
  }) async {
    try {
      final result = await _remoteDataSource.deleteTajwidQuestion(id: id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> submitTest({
    required String tajwidId,
    required Map<String, String> answers,
  }) async {
    try {
      final result = await _remoteDataSource.submitTest(
        tajwidId: tajwidId,
        answers: answers,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Pair<List<TajwidQuestion>, TestResponse?>> getTestResult({
    required String tajwidId,
    String? userId,
  }) async {
    try {
      final results = await Future.wait([
        _remoteDataSource.getTajwidQuestions(tajwidId: tajwidId),
        _remoteDataSource.getTestResponse(tajwidId: tajwidId, userId: userId),
      ]);

      final pair = Pair(
        results[0]! as List<TajwidQuestionModel>,
        results[1] as TestResponseModel?,
      );

      return Right(pair);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TestResult>> getTestResults({
    required String tajwidId,
  }) async {
    try {
      final result = await _remoteDataSource.getTestResults(
        tajwidId: tajwidId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on GeneralException catch (e) {
      return Left(GeneralFailure.fromException(e));
    }
  }
}
