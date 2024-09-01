import 'dart:async';

import 'package:alquran_app/core/common/widgets/action_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/injection/injection.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/auth/presentation/views/login_screen.dart';
import 'package:alquran_app/src/auth/presentation/views/register_screen.dart';
import 'package:alquran_app/src/home/presentation/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const path = '/welcome';
  static const name = 'welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  StreamSubscription<User?>? authListener;

  static bool _isFirstTimer() {
    final prefs = sl<SharedPreferences>();
    final isFirstTimer = prefs.getBool('isFirstTimer');
    return isFirstTimer ?? true;
  }

  @override
  void initState() {
    authListener = sl<FirebaseAuth>().authStateChanges().listen((user) {
      if (user == null && _isFirstTimer()) {
        return;
      } else if (user == null && !_isFirstTimer()) {
        context.goNamed(LogInScreen.name);
      } else {
        context.goNamed(HomeScreen.name);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    authListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Belajar ',
                              style: Typographies.bold32.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: 'Al-Quran',
                              style: Typographies.bold32.copyWith(
                                color: context.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        // ignore: lines_longer_than_80_chars
                        'Siapapun yang berjuang mencari ilmu karena Allah akan dijaga setiap langkah perjalanannya sampai ia kembali',
                        style: Typographies.medium13
                            .copyWith(color: context.colorScheme.secondary),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 64,
                        ),
                        child: Lottie.asset(Media.family),
                      ),
                      Column(
                        children: [
                          ActionButton(
                            onPressed: () =>
                                context.pushNamed(LogInScreen.name),
                            child: const Text('Sign In'),
                          ),
                          const SizedBox(height: 12),
                          ActionButton.outlined(
                            onPressed: () =>
                                context.pushNamed(RegisterScreen.name),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
