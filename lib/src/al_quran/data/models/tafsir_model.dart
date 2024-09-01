import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/tafsir.dart';

class TafsirModel extends Tafsir {
  const TafsirModel({
    required super.id,
  });

  factory TafsirModel.fromMap(DataMap map) {
    return TafsirModel(
      id: map['id'] as String,
    );
  }

  factory TafsirModel.fromJson(String source) =>
      TafsirModel.fromMap(json.decode(source) as DataMap);

  TafsirModel copyWith({
    String? id,
  }) {
    return TafsirModel(
      id: id ?? this.id,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'TafsirModel(id: $id)';
}
