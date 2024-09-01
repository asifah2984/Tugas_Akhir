import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/revelation.dart';

class RevelationModel extends Revelation {
  const RevelationModel({
    required super.arab,
    required super.en,
    required super.id,
  });

  factory RevelationModel.fromJson(String source) =>
      RevelationModel.fromMap(json.decode(source) as DataMap);

  factory RevelationModel.fromMap(DataMap map) {
    return RevelationModel(
      arab: map['arab'] as String,
      en: map['en'] as String,
      id: map['id'] as String,
    );
  }

  RevelationModel copyWith({
    String? arab,
    String? en,
    String? id,
  }) {
    return RevelationModel(
      arab: arab ?? this.arab,
      en: en ?? this.en,
      id: id ?? this.id,
    );
  }

  DataMap toMap() {
    return {
      'arab': arab,
      'en': en,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'RevelationModel(arab: $arab, en: $en, id: $id)';
}
