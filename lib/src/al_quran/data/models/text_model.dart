import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/transliteration_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/text.dart';
import 'package:alquran_app/src/al_quran/domain/entities/transliteration.dart';

class TextModel extends Text {
  const TextModel({
    required super.arab,
    required super.transliteration,
  });

  factory TextModel.fromMap(Map<String, dynamic> map) {
    return TextModel(
      arab: map['arab'] as String,
      transliteration:
          TransliterationModel.fromMap(map['transliteration'] as DataMap),
    );
  }

  factory TextModel.fromJson(String source) =>
      TextModel.fromMap(json.decode(source) as DataMap);

  @override
  List<Object> get props => [arab, transliteration];

  TextModel copyWith({
    String? arab,
    Transliteration? transliteration,
  }) {
    return TextModel(
      arab: arab ?? this.arab,
      transliteration: transliteration ?? this.transliteration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'arab': arab,
      'transliteration': (transliteration as TransliterationModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'TextModel(arab: $arab, transliteration: $transliteration)';
}
