import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/name_model.dart';
import 'package:alquran_app/src/al_quran/data/models/pre_bismillah_model.dart';
import 'package:alquran_app/src/al_quran/data/models/revelation_model.dart';
import 'package:alquran_app/src/al_quran/data/models/tafsir_model.dart';
import 'package:alquran_app/src/al_quran/data/models/verse_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/name.dart';
import 'package:alquran_app/src/al_quran/domain/entities/pre_bismillah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/revelation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:alquran_app/src/al_quran/domain/entities/tafsir.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:flutter/widgets.dart';

class SurahDetailModel extends SurahDetail {
  const SurahDetailModel({
    required super.number,
    required super.sequence,
    required super.numberOfVerses,
    required super.name,
    required super.revelation,
    required super.tafsir,
    required super.verses,
    super.preBismillah,
  });

  factory SurahDetailModel.fromJson(String source) =>
      SurahDetailModel.fromMap(json.decode(source) as DataMap);

  factory SurahDetailModel.fromMap(Map<String, dynamic> map) {
    return SurahDetailModel(
      number: map['number'] as int,
      sequence: map['sequence'] as int,
      numberOfVerses: map['numberOfVerses'] as int,
      name: NameModel.fromMap(map['name'] as DataMap),
      revelation: RevelationModel.fromMap(map['revelation'] as DataMap),
      tafsir: TafsirModel.fromMap(map['tafsir'] as DataMap),
      verses: List<Verse>.from(
        (map['verses'] as Iterable<dynamic>)
            .map((x) => VerseModel.fromMap(x as DataMap)),
      ),
      preBismillah: map['preBismillah'] != null
          ? PreBismillahModel.fromMap(map['preBismillah'] as DataMap)
          : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      number,
      sequence,
      numberOfVerses,
      name,
      revelation,
      tafsir,
      verses,
      preBismillah,
    ];
  }

  SurahDetailModel copyWith({
    int? number,
    int? sequence,
    int? numberOfVerses,
    Name? name,
    Revelation? revelation,
    Tafsir? tafsir,
    List<Verse>? verses,
    ValueGetter<PreBismillah?>? preBismillah,
  }) {
    return SurahDetailModel(
      number: number ?? this.number,
      sequence: sequence ?? this.sequence,
      numberOfVerses: numberOfVerses ?? this.numberOfVerses,
      name: name ?? this.name,
      revelation: revelation ?? this.revelation,
      tafsir: tafsir ?? this.tafsir,
      verses: verses ?? this.verses,
      preBismillah: preBismillah != null ? preBismillah() : this.preBismillah,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'sequence': sequence,
      'numberOfVerses': numberOfVerses,
      'name': (name as NameModel).toMap(),
      'revelation': (revelation as RevelationModel).toMap(),
      'tafsir': (tafsir as TafsirModel).toMap(),
      'verses': verses.map((x) => (x as VerseModel).toMap()).toList(),
      'preBismillah': preBismillah != null
          ? (preBismillah! as PreBismillahModel).toMap()
          : null,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SurahDetailModel(number: $number, sequence: $sequence, '
        'numberOfVerses: $numberOfVerses, name: $name, '
        'revelation: $revelation, tafsir: $tafsir, verses: $verses, '
        'preBismillah: $preBismillah)';
  }
}
