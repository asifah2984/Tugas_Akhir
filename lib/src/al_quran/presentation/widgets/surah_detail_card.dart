import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:flutter/material.dart';

class SurahDetailCard extends StatelessWidget {
  const SurahDetailCard({
    required this.surahDetail,
    required this.onPressed,
    super.key,
  });

  final SurahDetail surahDetail;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: Colours.gradient,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              surahDetail.name.transliteration.id?.toUpperCase() ??
                  'Surah ${surahDetail.number}',
              style: Typographies.medium16.copyWith(
                color: context.colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '( ${surahDetail.name.translation.id.toUpperCase()} )',
              style: Typographies.regular16.copyWith(
                color: context.colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${surahDetail.numberOfVerses} Ayat | '
              '${surahDetail.revelation.id}',
              style: Typographies.regular13.copyWith(
                color: context.colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
