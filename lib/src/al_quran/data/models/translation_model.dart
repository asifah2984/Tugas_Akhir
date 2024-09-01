import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';

class TranslationModel extends Translation {
  const TranslationModel({
    required super.en,
    required super.id,
  });

  factory TranslationModel.fromJson(String source) =>
      TranslationModel.fromMap(json.decode(source) as DataMap);

  factory TranslationModel.fromMap(DataMap map) {
    return TranslationModel(
      en: map['en'] as String,
      id: map['id'] as String,
    );
  }

  TranslationModel copyWith({
    String? en,
    String? id,
  }) {
    return TranslationModel(
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
  String toString() => 'TranslationModel(en: $en, id: $id)';
}
