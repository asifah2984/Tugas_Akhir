import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestResponseModel extends TestResponse {
  const TestResponseModel({
    required super.id,
    required super.userId,
    required super.tajwidId,
    required super.answers,
    required super.grade,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TestResponseModel.fromMap(DataMap map) {
    return TestResponseModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      tajwidId: map['tajwidId'] as String,
      answers:
          Map<String, String>.from(map['answers'] as Map<dynamic, dynamic>),
      grade: map['grade'] as double,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  factory TestResponseModel.fromJson(String source) =>
      TestResponseModel.fromMap(json.decode(source) as DataMap);

  TestResponseModel copyWith({
    String? id,
    String? userId,
    String? tajwidId,
    Map<String, String>? answers,
    double? grade,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TestResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tajwidId: tajwidId ?? this.tajwidId,
      answers: answers ?? this.answers,
      grade: grade ?? this.grade,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'userId': userId,
      'tajwidId': tajwidId,
      'answers': answers,
      'grade': grade,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TestResponseModel(id: $id, userId: $userId, tajwidId: $tajwidId, '
        'answers: $answers, grade: $grade, createdAt: ${createdAt.toDate()}, '
        'updatedAt: ${updatedAt.toDate()})';
  }
}
