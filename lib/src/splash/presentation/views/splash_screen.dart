import 'dart:async';

import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/injection/injection.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/utils/core_utils.dart';
import 'package:alquran_app/core/utils/enums.dart';
import 'package:alquran_app/src/auth/data/models/user_model.dart';
import 'package:alquran_app/src/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:alquran_app/src/auth/presentation/views/login_screen.dart';
import 'package:alquran_app/src/home/presentation/views/home_screen.dart';
import 'package:alquran_app/src/welcome/presentation/views/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const path = '/splash';
  static const name = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<User?>? _authListener;

  static bool _isFirstTimer() {
    final prefs = sl<SharedPreferences>();
    final isFirstTimer = prefs.getBool('isFirstTimer');
    return isFirstTimer ?? true;
  }

  @override
  void initState() {
    _authListener = sl<FirebaseAuth>().authStateChanges().listen((user) {
      if (user == null && _isFirstTimer()) {
        context.goNamed(WelcomeScreen.name);
      } else if (user == null && !_isFirstTimer()) {
        context.goNamed(LogInScreen.name);
      } else {
        context.read<AuthBloc>().add(const AuthEvent.getUserEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          getUserFailed: (message) {
            CoreUtils.showSnackBar(
              context: context,
              message: message,
              type: SnackBarType.error,
            );
            context.goNamed(LogInScreen.name);
          },
          userLoaded: (user) {
            context.read<UserNotifier>().initUser(user as LocalUserModel);
            context.goNamed(HomeScreen.name);
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Image.asset(
              Media.splash,
              width: 288,
              height: 288,
            ),
          ),
        ),
      ),
    );
  }
}
