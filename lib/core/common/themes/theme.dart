import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final theme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colours.primary,
      secondary: Colours.secondary,
      tertiary: Colours.tertiary,
      error: Colours.error500,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: Typographies.medium16.copyWith(
        color: Colours.generalText,
      ),
    ),
    useMaterial3: true,
  );
}
