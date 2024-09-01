import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/sajda_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/meta.dart';
import 'package:alquran_app/src/al_quran/domain/entities/sajda.dart';

class MetaModel extends Meta {
  const MetaModel({
    required super.juz,
    required super.page,
    required super.manzil,
    required super.ruku,
    required super.hizbQuarter,
    required super.sajda,
  });

  factory MetaModel.fromJson(String source) =>
      MetaModel.fromMap(json.decode(source) as DataMap);

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      juz: map['juz'] as int,
      page: map['page'] as int,
      manzil: map['manzil'] as int,
      ruku: map['ruku'] as int,
      hizbQuarter: map['hizbQuarter'] as int,
      sajda: SajdaModel.fromMap(map['sajda'] as DataMap),
    );
  }

  MetaModel copyWith({
    int? juz,
    int? page,
    int? manzil,
    int? ruku,
    int? hizbQuarter,
    Sajda? sajda,
  }) {
    return MetaModel(
      juz: juz ?? this.juz,
      page: page ?? this.page,
      manzil: manzil ?? this.manzil,
      ruku: ruku ?? this.ruku,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      sajda: sajda ?? this.sajda,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'juz': juz,
      'page': page,
      'manzil': manzil,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': (sajda as SajdaModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MetaModel(juz: $juz, page: $page, manzil: $manzil, ruku: $ruku, '
        'hizbQuarter: $hizbQuarter, sajda: $sajda)';
  }
}
