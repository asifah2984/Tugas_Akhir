import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/audio_model.dart';
import 'package:alquran_app/src/al_quran/data/models/meta_model.dart';
import 'package:alquran_app/src/al_quran/data/models/number_model.dart';
import 'package:alquran_app/src/al_quran/data/models/text_model.dart';
import 'package:alquran_app/src/al_quran/data/models/translation_model.dart';
import 'package:alquran_app/src/al_quran/data/models/verse_tafsir_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/audio.dart';
import 'package:alquran_app/src/al_quran/domain/entities/meta.dart';
import 'package:alquran_app/src/al_quran/domain/entities/number.dart';
import 'package:alquran_app/src/al_quran/domain/entities/text.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse_tafsir.dart';

class VerseModel extends Verse {
  const VerseModel({
    required super.number,
    required super.meta,
    required super.text,
    required super.translation,
    required super.audio,
    required super.tafsir,
    super.audioCondition = 'stop',
  });

  factory VerseModel.fromMap(Map<String, dynamic> map) {
    return VerseModel(
      number: NumberModel.fromMap(map['number'] as DataMap),
      meta: MetaModel.fromMap(map['meta'] as DataMap),
      text: TextModel.fromMap(map['text'] as DataMap),
      translation: TranslationModel.fromMap(map['translation'] as DataMap),
      audio: AudioModel.fromMap(map['audio'] as DataMap),
      tafsir: VerseTafsirModel.fromMap(map['tafsir'] as DataMap),
    );
  }

  factory VerseModel.fromJson(String source) =>
      VerseModel.fromMap(json.decode(source) as DataMap);

  VerseModel copyWith({
    Number? number,
    Meta? meta,
    Text? text,
    Translation? translation,
    Audio? audio,
    VerseTafsir? tafsir,
    String? audioCondition,
  }) {
    return VerseModel(
      number: number ?? this.number,
      meta: meta ?? this.meta,
      text: text ?? this.text,
      translation: translation ?? this.translation,
      audio: audio ?? this.audio,
      tafsir: tafsir ?? this.tafsir,
      audioCondition: audioCondition ?? this.audioCondition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': (number as NumberModel).toMap(),
      'meta': (meta as MetaModel).toMap(),
      'text': (text as TextModel).toMap(),
      'translation': (translation as TranslationModel).toMap(),
      'audio': (audio as AudioModel).toMap(),
      'tafsir': (tafsir as VerseTafsirModel).toMap(),
      'audioCondition': audioCondition,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'VerseModel(number: $number, meta: $meta, text: $text, '
        'translation: $translation, audio: $audio, tafsir: $tafsir, '
        'audioCondition: $audioCondition)';
  }
}
