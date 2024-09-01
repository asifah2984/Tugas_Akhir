import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/transliteration.dart';

class TransliterationModel extends Transliteration {
  const TransliterationModel({
    required super.en,
    required super.id,
  });

  factory TransliterationModel.fromJson(String source) =>
      TransliterationModel.fromMap(json.decode(source) as DataMap);

  factory TransliterationModel.fromMap(DataMap map) {
    return TransliterationModel(
      en: map['en'] as String,
      id: map['id'] as String?,
    );
  }

  TransliterationModel copyWith({
    String? en,
    String? id,
  }) {
    return TransliterationModel(
      en: en ?? this.en,
      id: id ?? this.id,
    );
  }

  DataMap toMap() {
    return {
      'en': en,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'TransliterationModel(en: $en, id: $id)';
}
