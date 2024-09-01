import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/number.dart';

class NumberModel extends Number {
  const NumberModel({
    required super.inQuran,
    required super.inSurah,
  });

  factory NumberModel.fromMap(Map<String, dynamic> map) {
    return NumberModel(
      inQuran: map['inQuran'] as int,
      inSurah: map['inSurah'] as int,
    );
  }

  factory NumberModel.fromJson(String source) =>
      NumberModel.fromMap(json.decode(source) as DataMap);

  NumberModel copyWith({
    int? inQuran,
    int? inSurah,
  }) {
    return NumberModel(
      inQuran: inQuran ?? this.inQuran,
      inSurah: inSurah ?? this.inSurah,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inQuran': inQuran,
      'inSurah': inSurah,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'NumberModel(inQuran: $inQuran, inSurah: $inSurah)';
}
