import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  void resetUser() {
    if (_user == null) return;

    _user = null;
  }

  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
