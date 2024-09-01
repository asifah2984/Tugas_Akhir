import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/id_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/id.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse_tafsir.dart';

class VerseTafsirModel extends VerseTafsir {
  const VerseTafsirModel({
    required super.id,
  });

  factory VerseTafsirModel.fromMap(Map<String, dynamic> map) {
    return VerseTafsirModel(
      id: IdModel.fromMap(map['id'] as DataMap),
    );
  }

  factory VerseTafsirModel.fromJson(String source) =>
      VerseTafsirModel.fromMap(json.decode(source) as DataMap);

  @override
  List<Object> get props => [id];

  VerseTafsirModel copyWith({
    Id? id,
  }) {
    return VerseTafsirModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': (id as IdModel).toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'VerseTafsirModel(id: $id)';
}
