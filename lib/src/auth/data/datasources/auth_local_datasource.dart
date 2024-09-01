import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> setFirstTimer();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> setFirstTimer() async {
    try {
      final isFirstTimer = _prefs.getBool('isFirstTimer') ?? true;

      if (isFirstTimer == false) return;

      await _prefs.setBool('isFirstTimer', false);
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }
}
