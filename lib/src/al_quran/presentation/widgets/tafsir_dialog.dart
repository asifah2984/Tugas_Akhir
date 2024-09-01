import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:flutter/material.dart';

class TafsirDialog extends StatelessWidget {
  const TafsirDialog({
    required this.title,
    required this.tafsir,
    super.key,
  });

  final String title;
  final String tafsir;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: Typographies.medium23.copyWith(
        color: context.colorScheme.secondary,
      ),
      content: Text(
        tafsir,
        textAlign: TextAlign.justify,
      ),
      contentTextStyle: Typographies.regular16.copyWith(
        color: context.colorScheme.secondary,
      ),
    );
  }
}
