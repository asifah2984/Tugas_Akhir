import 'dart:io';

import 'package:alquran_app/core/utils/pair.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_response.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_result.dart';

abstract class TajwidRepo {
  ResultFuture<List<Tajwid>> getTajwids();

  ResultFuture<List<TajwidMaterial>> getTajwidMaterials({
    required String tajwidId,
  });

  ResultFuture<File?> pickThumbnailImage();

  ResultFuture<void> addTajwid({
    required String tajwidName,
    required String tajwidDescription,
    required File thumbnailImage,
  });

  ResultFuture<void> editTajwid({
    required String id,
    required String? newTajwidName,
    required String? newTajwidDescription,
    required File? newThumbnailImage,
  });

  ResultFuture<void> deleteTajwid({
    required String id,
  });

  ResultFuture<void> addTajwidMaterial({
    required String tajwidId,
    required String content,
  });

  ResultFuture<void> editTajwidMaterial({
    required String id,
    required String newContent,
  });

  ResultFuture<void> deleteTajwidMaterial({
    required String id,
  });

  ResultFuture<List<TajwidQuestion>> getTajwidQuestions({
    required String tajwidId,
  });

  ResultFuture<void> addTajwidQuestion({
    required String tajwidId,
    required String question,
    required List<String> choices,
    required String answer,
  });

  ResultFuture<void> editTajwidQuestion({
    required String id,
    required String newQuestion,
    required List<String> newChoices,
    required String newAnswer,
  });

  ResultFuture<void> deleteTajwidQuestion({
    required String id,
  });

  ResultFuture<void> submitTest({
    required String tajwidId,
    required Map<String, String> answers,
  });

  ResultFuture<Pair<List<TajwidQuestion>, TestResponse?>> getTestResult({
    required String tajwidId,
    String? userId,
  });

  ResultFuture<List<TestResult>> getTestResults({
    required String tajwidId,
  });
}
