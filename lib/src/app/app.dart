import 'package:alquran_app/core/common/notifiers/user_notifier.dart';
import 'package:alquran_app/core/common/themes/theme.dart';
import 'package:alquran_app/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlquranApp extends StatelessWidget {
  const AlquranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserNotifier(),
      builder: (_, __) {
        return MaterialApp.router(
          title: 'Alquran',
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.routerConfig,
        );
      },
    );
  }
}
