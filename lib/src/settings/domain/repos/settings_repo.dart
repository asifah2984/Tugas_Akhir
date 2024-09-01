import 'package:alquran_app/core/utils/typedef.dart';

abstract class SettingsRepo {
  ResultFuture<void> updateEmail({
    required String currentEmail,
    required String newEmail,
    required String password,
  });

  ResultFuture<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  });
}
