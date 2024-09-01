import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TajwidModel extends Tajwid {
  const TajwidModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TajwidModel.fromJson(String source) =>
      TajwidModel.fromMap(json.decode(source) as DataMap);

  factory TajwidModel.fromMap(DataMap map) {
    return TajwidModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  TajwidModel copyWith({
    String? id,
    int? number,
    String? name,
    String? description,
    String? imageUrl,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TajwidModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TajwidModel(id: $id, name: $name, description: $description, '
        'imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
