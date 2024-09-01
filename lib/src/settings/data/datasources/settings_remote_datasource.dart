import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class SettingsRemoteDataSource {
  Future<void> updateEmail({
    required String currentEmail,
    required String newEmail,
    required String password,
  });

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  });
}

@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  const SettingsRemoteDataSourceImpl({
    required FirebaseAuth authClient,
  }) : _authClient = authClient;

  final FirebaseAuth _authClient;

  @override
  Future<void> updateEmail({
    required String currentEmail,
    required String newEmail,
    required String password,
  }) async {
    try {
      await _authClient.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentEmail,
          password: password,
        ),
      );
      await _authClient.currentUser!.verifyBeforeUpdateEmail(newEmail);
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
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    try {
      await _authClient.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: currentPassword,
        ),
      );
      await _authClient.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? kDefaultErrorMessage,
      );
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }
}
