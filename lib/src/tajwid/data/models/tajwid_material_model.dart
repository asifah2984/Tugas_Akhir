import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TajwidMaterialModel extends TajwidMaterial {
  const TajwidMaterialModel({
    required super.id,
    required super.tajwidId,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TajwidMaterialModel.fromMap(DataMap map) {
    return TajwidMaterialModel(
      id: map['id'] as String,
      tajwidId: map['tajwidId'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  factory TajwidMaterialModel.fromJson(String source) =>
      TajwidMaterialModel.fromMap(json.decode(source) as DataMap);

  TajwidMaterialModel copyWith({
    String? id,
    String? tajwidId,
    String? content,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TajwidMaterialModel(
      id: id ?? this.id,
      tajwidId: tajwidId ?? this.tajwidId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'tajwidId': tajwidId,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TajwidMaterialModel(id: $id, tajwidId: $tajwidId, '
        'content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
