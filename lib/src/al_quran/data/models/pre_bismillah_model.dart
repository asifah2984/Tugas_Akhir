import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/audio_model.dart';
import 'package:alquran_app/src/al_quran/data/models/text_model.dart';
import 'package:alquran_app/src/al_quran/data/models/translation_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/audio.dart';
import 'package:alquran_app/src/al_quran/domain/entities/pre_bismillah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/text.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';

class PreBismillahModel extends PreBismillah {
  const PreBismillahModel({
    required super.text,
    required super.translation,
    required super.audio,
  });

  factory PreBismillahModel.fromMap(Map<String, dynamic> map) {
    return PreBismillahModel(
      text: TextModel.fromMap(map['text'] as DataMap),
      translation: TranslationModel.fromMap(map['translation'] as DataMap),
      audio: AudioModel.fromMap(map['audio'] as DataMap),
    );
  }

  factory PreBismillahModel.fromJson(String source) =>
      PreBismillahModel.fromMap(json.decode(source) as DataMap);

  @override
  List<Object> get props => [text, translation, audio];

  PreBismillahModel copyWith({
    Text? text,
    Translation? translation,
    Audio? audio,
  }) {
    return PreBismillahModel(
      text: text ?? this.text,
      translation: translation ?? this.translation,
      audio: audio ?? this.audio,
    );
  }

  DataMap toMap() {
    return {
      'text': (text as TextModel).toMap(),
      'translation': (translation as TranslationModel).toMap(),
      'audio': (audio as AudioModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'PreBismillahModel(text: $text, '
      'translation: $translation, audio: $audio)';
}
