import 'package:alquran_app/core/extensions/context_extension.dart';
import 'package:alquran_app/core/resources/colours.dart';
import 'package:alquran_app/core/resources/media.dart';
import 'package:alquran_app/core/resources/typographies.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/blocs/bookmark_bloc/bookmark_bloc.dart';
import 'package:alquran_app/src/al_quran/presentation/widgets/bookmark_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerseContent extends StatelessWidget {
  const VerseContent({
    required this.index,
    required this.verse,
    this.surah,
    this.surahId,
    super.key,
  });

  final int index;
  final Verse verse;
  final String? surah;
  final int? surahId;

  void _onBookmark(
    BuildContext context, {
    required Verse verse,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BookmarkBloc>(),
          child: BookmarkDialog(
            type: surah != null ? 'surah' : 'juz',
            verse: verse,
            surah: surah,
            surahId: surahId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioPlayerBloc, AudioPlayerState>(
      listener: (context, state) {
        state.maybeWhen(
          audioError: (message) {
            showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          orElse: () {},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colorScheme.tertiary.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Media.listDark),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: Typographies.regular13.copyWith(
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // ? Uncomment here to view the ayah title (if provided by
                    // ? API)
                    // Builder(
                    //   builder: (context) {
                    //     final ayah = verse.audio.primary
                    //         .split('/')[6]
                    //         .split('.')
                    //         .map(
                    //           (name) =>
                    //               name[0].toUpperCase() + name.substring(1),
                    //         )
                    //         .join('-');
                    //     final number = verse.audio.primary.split('/')[7];
                    //     return Text(
                    //       '$ayah | Ayat $number',
                    //       style: Typographies.medium13.copyWith(
                    //         color: context.colorScheme.secondary,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _onBookmark(context, verse: verse),
                      icon: const Icon(Icons.bookmark_add_outlined),
                      color: Colours.greyText,
                    ),
                    BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                      builder: (context, state) {
                        final isPlaying = state.maybeWhen(
                          audioPlaying: (url) => url == verse.audio.primary,
                          orElse: () => false,
                        );
                        return IconButton(
                          onPressed: () {
                            context.read<AudioPlayerBloc>().add(
                                  AudioPlayerEvent.playAudioEvent(
                                    url: verse.audio.primary,
                                  ),
                                );
                          },
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          color: Colours.greyText,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            verse.text.arab,
            style: Typographies.medium23.copyWith(
              color: context.colorScheme.secondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            verse.text.transliteration.en,
            style: Typographies.light16.copyWith(
              color: context.colorScheme.secondary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Text(
            verse.translation.id,
            style: Typographies.light16.copyWith(
              color: context.colorScheme.secondary,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
