import 'package:alquran_app/core/common/widgets/reload_button.dart';
import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/surah_bloc/surah_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/surah_detail_card.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/tafsir_dialog.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/verse_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({
    required this.number,
    required this.title,
    super.key,
  });

  static const path = 'surah/:number';
  static const name = 'surah-detail';

  final int number;
  final String title;

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  void _getSurahDetail() {
    context.read<SurahBloc>().add(
          SurahEvent.getSurahDetailEvent(
            number: widget.number,
          ),
        );
  }

  void _viewTafsir({
    required String title,
    required String tafsir,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return TafsirDialog(title: title, tafsir: tafsir);
      },
    );
  }

  @override
  void initState() {
    _getSurahDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // ignore: lines_longer_than_80_chars
          widget.title,
          style: Typographies.bold16.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
      ),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          return state.maybeWhen(
            gettingSurahDetail: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            getSurahDetailFailed: _buildError,
            surahDetailLoaded: _buildContent,
            orElse: Container.new,
          );
        },
      ),
    );
  }

  Widget _buildContent(SurahDetail surahDetail) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SurahDetailCard(
            surahDetail: surahDetail,
            onPressed: () => _viewTafsir(
              title: 'Tafsir ${surahDetail.name.transliteration.id ?? 'Surah '
                  '${surahDetail.number}'}',
              tafsir: surahDetail.tafsir.id,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 28),
              itemCount: surahDetail.verses.length,
              itemBuilder: (context, index) {
                final verse = surahDetail.verses[index];
                return VerseContent(
                  index: index + 1,
                  verse: verse,
                  surah: widget.title,
                  surahId: widget.number,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 36);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 12),
          ReloadButton(
            label: 'Muat Ulang',
            onPressed: _getSurahDetail,
          ),
        ],
      ),
    );
  }
}
