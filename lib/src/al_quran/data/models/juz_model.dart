import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/verse_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';

class JuzModel extends Juz {
  const JuzModel({
    required super.juz,
    required super.juzStartSurahNumber,
    required super.juzEndSurahNumber,
    required super.juzStartInfo,
    required super.juzEndInfo,
    required super.totalVerses,
    required super.verses,
  });

  factory JuzModel.fromMap(DataMap map) {
    return JuzModel(
      juz: map['juz'] as int,
      juzStartSurahNumber: map['juzStartSurahNumber'] as int,
      juzEndSurahNumber: int.tryParse(['juzEndSurahNumber'].toString()) ?? 0,
      juzStartInfo: map['juzStartInfo'] as String,
      juzEndInfo: map['juzEndInfo'] as String,
      totalVerses: map['totalVerses'] as int,
      verses: List<Verse>.from(
        (map['verses'] as Iterable<dynamic>).map(
          (x) => VerseModel.fromMap(x as DataMap),
        ),
      ),
    );
  }

  factory JuzModel.fromJson(String source) =>
      JuzModel.fromMap(json.decode(source) as DataMap);

  JuzModel copyWith({
    int? juz,
    int? juzStartSurahNumber,
    int? juzEndSurahNumber,
    String? juzStartInfo,
    String? juzEndInfo,
    int? totalVerses,
    List<Verse>? verses,
  }) {
    return JuzModel(
      juz: juz ?? this.juz,
      juzStartSurahNumber: juzStartSurahNumber ?? this.juzStartSurahNumber,
      juzEndSurahNumber: juzEndSurahNumber ?? this.juzEndSurahNumber,
      juzStartInfo: juzStartInfo ?? this.juzStartInfo,
      juzEndInfo: juzEndInfo ?? this.juzEndInfo,
      totalVerses: totalVerses ?? this.totalVerses,
      verses: verses ?? this.verses,
    );
  }

  DataMap toMap() {
    return {
      'juz': juz,
      'juzStartSurahNumber': juzStartSurahNumber,
      'juzEndSurahNumber': juzEndSurahNumber,
      'juzStartInfo': juzStartInfo,
      'juzEndInfo': juzEndInfo,
      'totalVerses': totalVerses,
      'verses': verses.map((x) => (x as VerseModel).toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'JuzModel(juz: $juz, juzStartSurahNumber: $juzStartSurahNumber, '
        'juzEndSurahNumber: $juzEndSurahNumber, juzStartInfo: $juzStartInfo, '
        'juzEndInfo: $juzEndInfo, totalVerses: $totalVerses, verses: $verses)';
  }
}
