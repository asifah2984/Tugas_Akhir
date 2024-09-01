// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:alquran_app/src/tajwid/data/models/tajwid_material_model.dart';
import 'package:alquran_app/src/tajwid/data/models/tajwid_model.dart';
import 'package:alquran_app/src/tajwid/data/models/tajwid_question_model.dart';
import 'package:alquran_app/src/tajwid/data/models/test_response_model.dart';
import 'package:alquran_app/src/tajwid/data/models/test_result_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

abstract class TajwidRemoteDataSource {
  Future<List<TajwidModel>> getTajwids();

  Future<void> addTajwid({
    required String tajwidName,
    required String tajwidDescription,
    required File thumbnailImage,
  });

  Future<void> editTajwid({
    required String id,
    required String? newTajwidName,
    required String? newTajwidDescription,
    required File? newThumbnailImage,
  });

  Future<void> deleteTajwid({
    required String id,
  });

  Future<List<TajwidMaterialModel>> getTajwidMaterials({
    required String tajwidId,
  });

  Future<void> addTajwidMaterial({
    required String tajwidId,
    required String content,
  });

  Future<void> editTajwidMaterial({
    required String id,
    required String newContent,
  });

  Future<void> deleteTajwidMaterial({
    required String id,
  });

  Future<List<TajwidQuestionModel>> getTajwidQuestions({
    required String tajwidId,
  });

  Future<void> addTajwidQuestion({
    required String tajwidId,
    required String question,
    required List<String> choices,
    required String answer,
  });

  Future<void> editTajwidQuestion({
    required String id,
    required String newQuestion,
    required List<String> newChoices,
    required String newAnswer,
  });

  Future<void> deleteTajwidQuestion({
    required String id,
  });

  Future<void> submitTest({
    required String tajwidId,
    required Map<String, String> answers,
  });

  Future<TestResponseModel?> getTestResponse({
    required String tajwidId,
    String? userId,
  });

  Future<List<TestResultModel>> getTestResults({
    required String tajwidId,
  });
}

@LazySingleton(as: TajwidRemoteDataSource)
class TajwidRemoteDataSourceImpl implements TajwidRemoteDataSource {
  const TajwidRemoteDataSourceImpl({
    required FirebaseFirestore dbClient,
    required FirebaseAuth authClient,
    required FirebaseStorage storageClient,
  })  : _authClient = authClient,
        _dbClient = dbClient,
        _storageClient = storageClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _dbClient;
  final FirebaseStorage _storageClient;

  @override
  Future<List<TajwidModel>> getTajwids() async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await _dbClient
          .collection('tajwids')
          .orderBy('createdAt', descending: false)
          .get();

      final tajwids =
          data.docs.map((doc) => TajwidModel.fromMap(doc.data())).toList();

      return tajwids;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> addTajwid({
    required String tajwidName,
    required String tajwidDescription,
    required File thumbnailImage,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final tajwidRef = _dbClient.collection('tajwids').doc();

      final thumbnailRef =
          _storageClient.ref().child('/tajwids').child(tajwidRef.id).child(
                // ignore: lines_longer_than_80_chars
                'thumbnail-${tajwidRef.id}.${thumbnailImage.path.split('.').last}',
              );

      await thumbnailRef.putFile(thumbnailImage);

      final thumbnailUrl = await thumbnailRef.getDownloadURL();

      final now = Timestamp.fromDate(DateTime.now());

      final tajwidModel = TajwidModel(
        id: tajwidRef.id,
        name: tajwidName,
        description: tajwidDescription,
        imageUrl: thumbnailUrl,
        createdAt: now,
        updatedAt: now,
      );

      await tajwidRef.set(tajwidModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> editTajwid({
    required String id,
    required String? newTajwidName,
    required String? newTajwidDescription,
    required File? newThumbnailImage,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final now = Timestamp.fromDate(DateTime.now());

      final tajwidRef = _dbClient.collection('tajwids').doc(id);

      if (newTajwidName != null) {
        await tajwidRef.update({
          'name': newTajwidName,
          'updatedAt': now,
        });
      }

      if (newTajwidDescription != null) {
        await tajwidRef.update({
          'description': newTajwidDescription,
          'updatedAt': now,
        });
      }

      if (newThumbnailImage != null) {
        final thumbnailRef =
            _storageClient.ref().child('/tajwids').child(tajwidRef.id).child(
                  // ignore: lines_longer_than_80_chars
                  'thumbnail-${tajwidRef.id}.${newThumbnailImage.path.split('.').last}',
                );

        await thumbnailRef.putFile(newThumbnailImage);

        final thumbnailUrl = await thumbnailRef.getDownloadURL();

        await tajwidRef.update({
          'imageUrl': thumbnailUrl,
          'updatedAt': now,
        });
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTajwid({
    required String id,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final responsesRef = await _dbClient
          .collection('testResponses')
          .where('tajwidId', isEqualTo: id)
          .get();
      responsesRef.docs
          .forEach((doc) async => doc.exists ? doc.reference.delete() : null);

      final questionsRef = await _dbClient
          .collection('questions')
          .where('tajwidId', isEqualTo: id)
          .get();
      questionsRef.docs
          .forEach((doc) async => doc.exists ? doc.reference.delete() : null);

      final materialsRef = await _dbClient
          .collection('materials')
          .where('tajwidId', isEqualTo: id)
          .get();
      materialsRef.docs
          .forEach((doc) async => doc.exists ? doc.reference.delete() : null);

      final thumbnailStorageRef =
          _storageClient.ref().child('tajwids').child(id);
      final files = await thumbnailStorageRef.listAll();
      files.items.forEach((file) async => file.delete());

      final tajwidRef = _dbClient.collection('tajwids').doc(id);
      await tajwidRef.delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<List<TajwidMaterialModel>> getTajwidMaterials({
    required String tajwidId,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await _dbClient
          .collection('materials')
          .where('tajwidId', isEqualTo: tajwidId)
          .orderBy('createdAt', descending: false)
          .get();

      final materials = data.docs
          .map((doc) => TajwidMaterialModel.fromMap(doc.data()))
          .toList();

      return materials;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> addTajwidMaterial({
    required String tajwidId,
    required String content,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final now = DateTime.now();
      final materialRef = _dbClient.collection('materials').doc();

      final materialModel = TajwidMaterialModel(
        id: materialRef.id,
        tajwidId: tajwidId,
        content: content,
        createdAt: Timestamp.fromDate(now),
        updatedAt: Timestamp.fromDate(now),
      );

      await materialRef.set(materialModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> editTajwidMaterial({
    required String id,
    required String newContent,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final now = DateTime.now();

      final materialRef = _dbClient.collection('materials').doc(id);
      await materialRef.update({
        'content': newContent,
        'updatedAt': Timestamp.fromDate(now),
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTajwidMaterial({
    required String id,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      await _dbClient.collection('materials').doc(id).delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<List<TajwidQuestionModel>> getTajwidQuestions({
    required String tajwidId,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await _dbClient
          .collection('questions')
          .where('tajwidId', isEqualTo: tajwidId)
          .orderBy('createdAt', descending: false)
          .get();

      final questions = data.docs
          .map((doc) => TajwidQuestionModel.fromMap(doc.data()))
          .toList();

      return questions;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> addTajwidQuestion({
    required String tajwidId,
    required String question,
    required List<String> choices,
    required String answer,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final now = DateTime.now();
      final questionRef = _dbClient.collection('questions').doc();

      final questionModel = TajwidQuestionModel(
        id: questionRef.id,
        tajwidId: tajwidId,
        question: question,
        choices: choices,
        answer: answer,
        createdAt: Timestamp.fromDate(now),
        updatedAt: Timestamp.fromDate(now),
      );

      await questionRef.set(questionModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> editTajwidQuestion({
    required String id,
    required String newQuestion,
    required List<String> newChoices,
    required String newAnswer,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final now = DateTime.now();
      final questionRef = _dbClient.collection('questions').doc(id);

      await questionRef.update({
        'question': newQuestion,
        'choices': newChoices,
        'answer': newAnswer,
        'updatedAt': Timestamp.fromDate(now),
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTajwidQuestion({
    required String id,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      await _dbClient.collection('questions').doc(id).delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> submitTest({
    required String tajwidId,
    required Map<String, String> answers,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final questions = await getTajwidQuestions(tajwidId: tajwidId);
      final correctAnswerCount = questions.fold(0, (prevGrade, question) {
        return prevGrade + (question.answer == answers[question.id] ? 1 : 0);
      });
      final grade = (correctAnswerCount / questions.length) * 100;

      final testResponseRef = _dbClient.collection('testResponses').doc();
      final now = DateTime.now();

      final testResponseModel = TestResponseModel(
        id: testResponseRef.id,
        userId: user.uid,
        tajwidId: tajwidId,
        answers: answers,
        grade: grade,
        createdAt: Timestamp.fromDate(now),
        updatedAt: Timestamp.fromDate(now),
      );

      await testResponseRef.set(testResponseModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<TestResponseModel?> getTestResponse({
    required String tajwidId,
    String? userId,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await _dbClient
          .collection('testResponses')
          .where('userId', isEqualTo: userId ?? user.uid)
          .where('tajwidId', isEqualTo: tajwidId)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (data.docs.isEmpty) return null;

      final response = TestResponseModel.fromMap(data.docs[0].data());

      return response;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<List<TestResultModel>> getTestResults({
    required String tajwidId,
  }) async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await Future.wait([
        _dbClient.collection('users').get(),
        _dbClient
            .collection('testResponses')
            .where('tajwidId', isEqualTo: tajwidId)
            .get(),
      ]);

      final usersData = data[0];
      final responsesData = data[1];

      final users = <LocalUserModel>[];
      for (final user in usersData.docs) {
        users.add(LocalUserModel.fromMap(user.data()));
      }

      final responses = <TestResponseModel>[];
      for (final response in responsesData.docs) {
        responses.add(TestResponseModel.fromMap(response.data()));
      }
      responses.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final results = <TestResultModel>[];

      for (final user in users) {
        final response = responses
            .firstWhereOrNull((response) => response.userId == user.id);
        if (response == null) continue;

        final result = TestResultModel(
          userId: user.id,
          tajwidId: response.tajwidId,
          userName: user.name,
          grade: response.grade,
          createdAt: response.createdAt,
          updatedAt: response.updatedAt,
          userEmail: user.email.isEmpty ? null : user.email,
        );
        results.add(result);
      }

      return results;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }
}
