import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TajwidTestResultModel extends TajwidTestResult {
  const TajwidTestResultModel({
    required super.tajwidId,
    required super.tajwidName,
    required super.tajwidDescription,
    required super.grade,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TajwidTestResultModel.fromMap(DataMap map) {
    return TajwidTestResultModel(
      tajwidId: map['tajwidId'] as String,
      tajwidName: map['tajwidName'] as String,
      tajwidDescription: map['tajwidDescription'] as String,
      grade: map['grade'] as double,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  factory TajwidTestResultModel.fromJson(String source) =>
      TajwidTestResultModel.fromMap(json.decode(source) as DataMap);

  TajwidTestResultModel copyWith({
    String? tajwidId,
    String? tajwidName,
    String? tajwidDescription,
    double? grade,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TajwidTestResultModel(
      tajwidId: tajwidId ?? this.tajwidId,
      tajwidName: tajwidName ?? this.tajwidName,
      tajwidDescription: tajwidDescription ?? this.tajwidDescription,
      grade: grade ?? this.grade,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'tajwidId': tajwidId,
      'tajwidName': tajwidName,
      'tajwidDescription': tajwidDescription,
      'grade': grade,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TajwidTestResultModel(tajwidId: $tajwidId, '
        'tajwidName: $tajwidName, tajwidDescription: $tajwidDescription, '
        'grade: $grade, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
