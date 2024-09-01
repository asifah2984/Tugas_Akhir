import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<LocalUserModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> resetPassword({
    required String email,
  });

  Future<void> logoutUser();

  Future<LocalUserModel> getUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore dbClient,
  })  : _authClient = authClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _dbClient;

  @override
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      // store user data in Firebase Firestore
      await _setUserData(
        user: userCredential.user!,
        fallbackName: name,
        fallbackEmail: email,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<LocalUserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw const ServerException(
          statusCode: 'unknown-error',
          message: kDefaultErrorMessage,
        );
      }

      var userData = await _getUserData(user.uid);

      // if user data is not exist in Firestore, create one
      if (!userData.exists) {
        await _setUserData(
          user: user,
          fallbackName: 'User',
          fallbackEmail: email,
        );

        userData = await _getUserData(user.uid);

        final data = {
          ...userData.data()!,
          'email': user.email,
        };

        return LocalUserModel.fromMap(data);
      }

      final data = {
        ...userData.data()!,
        'email': user.email,
      };

      return LocalUserModel.fromMap(data);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _authClient.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<LocalUserModel> getUser() async {
    try {
      final user = _authClient.currentUser;

      if (user == null) {
        throw const ServerException(
          statusCode: '401',
          message: 'User is not authenticated',
        );
      }

      final data = await _dbClient.collection('users').doc(user.uid).get();

      final rawUser = {...data.data()!, 'email': user.email};

      final userModel = LocalUserModel.fromMap(rawUser);

      return userModel;
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  Future<void> _setUserData({
    required User user,
    required String fallbackName,
    required String fallbackEmail,
  }) async {
    try {
      final map = LocalUserModel(
        id: user.uid,
        name: user.displayName ?? fallbackName,
        email: user.email ?? fallbackEmail,
      ).toMap()
        ..removeWhere((key, value) => key == 'email');

      await _dbClient.collection('users').doc(user.uid).set(
            map,
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(
        message: e.toString(),
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _dbClient.collection('users').doc(uid).get();
  }
}
