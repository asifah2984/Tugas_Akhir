import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';
import 'package:alquran_app/src/tajwid/data/models/tajwid_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSource {
  Future<List<TajwidTestResult>> getTajwidTestResults();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore dbClient,
  })  : _authClient = authClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _dbClient;

  @override
  Future<List<TajwidTestResult>> getTajwidTestResults() async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final tajwidsSnapshot =
          await _dbClient.collection('tajwids').orderBy('createdAt').get();
      final tajwids = tajwidsSnapshot.docs
          .map((map) => TajwidModel.fromMap(map.data()))
          .toList();

      final results = <TajwidTestResult>[];

      for (final tajwid in tajwids) {
        final testResult = await _dbClient
            .collection('testResponses')
            .where('tajwidId', isEqualTo: tajwid.id)
            .where('userId', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();

        results.add(
          TajwidTestResult(
            tajwidId: tajwid.id,
            tajwidName: tajwid.name,
            tajwidDescription: tajwid.description,
            grade: testResult.docs.isNotEmpty
                ? testResult.docs[0].data()['grade'] as double
                : 0,
            createdAt: tajwid.createdAt,
            updatedAt: tajwid.updatedAt,
          ),
        );
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
