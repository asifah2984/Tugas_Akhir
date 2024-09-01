import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/id.dart';

class IdModel extends Id {
  const IdModel({
    required super.short,
    required super.long,
  });

  factory IdModel.fromMap(Map<String, dynamic> map) {
    return IdModel(
      short: map['short'] as String,
      long: map['long'] as String,
    );
  }

  factory IdModel.fromJson(String source) =>
      IdModel.fromMap(json.decode(source) as DataMap);

  @override
  List<Object> get props => [short, long];

  IdModel copyWith({
    String? short,
    String? long,
  }) {
    return IdModel(
      short: short ?? this.short,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'short': short,
      'long': long,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'IdModel(short: $short, long: $long)';
}
