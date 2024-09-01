import 'package:alquran_app/src/al_quran/domain/entities/audio.dart';
import 'package:alquran_app/src/al_quran/domain/entities/meta.dart';
import 'package:alquran_app/src/al_quran/domain/entities/number.dart';
import 'package:alquran_app/src/al_quran/domain/entities/text.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse_tafsir.dart';
import 'package:equatable/equatable.dart';

class Verse extends Equatable {
  const Verse({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
    required this.tafsir,
    this.audioCondition = 'stop',
  });

  final Number number;
  final Meta meta;
  final Text text;
  final Translation translation;
  final Audio audio;
  final VerseTafsir tafsir;
  final String audioCondition;

  @override
  List<Object?> get props => [
        number,
        meta,
        text,
        translation,
        audio,
        tafsir,
        audioCondition,
      ];
}
