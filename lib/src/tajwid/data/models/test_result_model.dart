import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class TestResultModel extends TestResult {
  const TestResultModel({
    required super.userId,
    required super.tajwidId,
    required super.userName,
    required super.grade,
    required super.createdAt,
    required super.updatedAt,
    super.userEmail,
  });

  factory TestResultModel.fromMap(DataMap map) {
    return TestResultModel(
      userId: map['userId'] as String,
      tajwidId: map['tajwidId'] as String,
      userName: map['userName'] as String,
      grade: map['grade'] as double,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
      userEmail: map['userEmail'] as String?,
    );
  }

  factory TestResultModel.fromJson(String source) =>
      TestResultModel.fromMap(json.decode(source) as DataMap);

  TestResultModel copyWith({
    String? userId,
    String? tajwidId,
    String? userName,
    double? grade,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    ValueGetter<String?>? userEmail,
  }) {
    return TestResultModel(
      userId: userId ?? this.userId,
      tajwidId: tajwidId ?? this.tajwidId,
      userName: userName ?? this.userName,
      grade: grade ?? this.grade,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userEmail: userEmail != null ? userEmail() : this.userEmail,
    );
  }

  DataMap toMap() {
    return {
      'userId': userId,
      'tajwidId': tajwidId,
      'userName': userName,
      'grade': grade,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userEmail': userEmail,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TestResultModel(userId: $userId, tajwidId: $tajwidId, '
        'userName: $userName, grade: $grade, createdAt: $createdAt, '
        'updatedAt: $updatedAt, userEmail: $userEmail)';
  }
}
