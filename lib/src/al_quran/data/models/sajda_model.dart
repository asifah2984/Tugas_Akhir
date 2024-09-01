import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/sajda.dart';

class SajdaModel extends Sajda {
  const SajdaModel({
    required super.recommended,
    required super.obligatory,
  });

  factory SajdaModel.fromMap(Map<String, dynamic> map) {
    return SajdaModel(
      recommended: map['recommended'] as bool,
      obligatory: map['obligatory'] as bool,
    );
  }

  factory SajdaModel.fromJson(String source) =>
      SajdaModel.fromMap(json.decode(source) as DataMap);

  SajdaModel copyWith({
    bool? recommended,
    bool? obligatory,
  }) {
    return SajdaModel(
      recommended: recommended ?? this.recommended,
      obligatory: obligatory ?? this.obligatory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended': recommended,
      'obligatory': obligatory,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'SajdaModel(recommended: $recommended, obligatory: $obligatory)';
}
