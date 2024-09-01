import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/verse_content.dart';
import 'package:flutter/material.dart';

class JuzDetailScreen extends StatelessWidget {
  const JuzDetailScreen({
    required this.juz,
    super.key,
  });

  final Juz juz;

  static const path = 'juz/:juz';
  static const name = 'juz-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Juz ${juz.juz}',
          style: Typographies.bold16.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: juz.verses.length,
        itemBuilder: (context, index) {
          final verse = juz.verses[index];
          return VerseContent(index: index + 1, verse: verse);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 36);
        },
      ),
    );
  }
}
