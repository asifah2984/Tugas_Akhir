import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/name_model.dart';
import 'package:alquran_app/src/al_quran/data/models/revelation_model.dart';
import 'package:alquran_app/src/al_quran/data/models/tafsir_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/name.dart';
import 'package:alquran_app/src/al_quran/domain/entities/revelation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/tafsir.dart';

class SurahModel extends Surah {
  const SurahModel({
    required super.number,
    required super.sequence,
    required super.numberOfVerses,
    required super.name,
    required super.revelation,
    required super.tafsir,
  });

  factory SurahModel.fromJson(String source) =>
      SurahModel.fromMap(json.decode(source) as DataMap);

  factory SurahModel.fromMap(DataMap map) {
    return SurahModel(
      number: map['number'] as int,
      sequence: map['sequence'] as int,
      numberOfVerses: map['numberOfVerses'] as int,
      name: NameModel.fromMap(map['name'] as DataMap),
      revelation: RevelationModel.fromMap(map['revelation'] as DataMap),
      tafsir: TafsirModel.fromMap(map['tafsir'] as DataMap),
    );
  }

  @override
  List<Object?> get props => [
        number,
        sequence,
        numberOfVerses,
        name,
        revelation,
        tafsir,
      ];

  SurahModel copyWith({
    int? number,
    int? sequence,
    int? numberOfVerses,
    Name? name,
    Revelation? revelation,
    Tafsir? tafsir,
  }) {
    return SurahModel(
      number: number ?? this.number,
      sequence: sequence ?? this.sequence,
      numberOfVerses: numberOfVerses ?? this.numberOfVerses,
      name: name ?? this.name,
      revelation: revelation ?? this.revelation,
      tafsir: tafsir ?? this.tafsir,
    );
  }

  DataMap toMap() {
    return {
      'number': number,
      'sequence': sequence,
      'numberOfVerses': numberOfVerses,
      'name': (name as NameModel).toMap(),
      'revelation': (revelation as RevelationModel).toMap(),
      'tafsir': (tafsir as TafsirModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SurahModel(number: $number, sequence: $sequence, '
        'numberOfVerses: $numberOfVerses, name: $name, '
        'revelation: $revelation, tafsir: $tafsir)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SurahModel &&
        other.number == number &&
        other.sequence == sequence &&
        other.numberOfVerses == numberOfVerses &&
        other.name == name &&
        other.revelation == revelation &&
        other.tafsir == tafsir;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        sequence.hashCode ^
        numberOfVerses.hashCode ^
        name.hashCode ^
        revelation.hashCode ^
        tafsir.hashCode;
  }
}
