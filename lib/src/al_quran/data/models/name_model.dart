import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/translation_model.dart';
import 'package:alquran_app/src/al_quran/data/models/transliteration_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/name.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/transliteration.dart';

class NameModel extends Name {
  const NameModel({
    required super.short,
    required super.long,
    required super.transliteration,
    required super.translation,
  });

  factory NameModel.fromMap(DataMap map) {
    return NameModel(
      short: map['short'] as String,
      long: map['long'] as String,
      transliteration:
          TransliterationModel.fromMap(map['transliteration'] as DataMap),
      translation: TranslationModel.fromMap(map['translation'] as DataMap),
    );
  }

  factory NameModel.fromJson(String source) =>
      NameModel.fromMap(json.decode(source) as DataMap);

  NameModel copyWith({
    String? short,
    String? long,
    Transliteration? transliteration,
    Translation? translation,
  }) {
    return NameModel(
      short: short ?? this.short,
      long: long ?? this.long,
      transliteration: transliteration ?? this.transliteration,
      translation: translation ?? this.translation,
    );
  }

  DataMap toMap() {
    return {
      'short': short,
      'long': long,
      'transliteration': (transliteration as TransliterationModel).toMap(),
      'translation': (translation as TranslationModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NameModel(short: $short, long: $long, '
        'transliteration: $transliteration, translation: $translation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NameModel &&
        other.short == short &&
        other.long == long &&
        other.transliteration == transliteration &&
        other.translation == translation;
  }

  @override
  int get hashCode {
    return short.hashCode ^
        long.hashCode ^
        transliteration.hashCode ^
        translation.hashCode;
  }
}
