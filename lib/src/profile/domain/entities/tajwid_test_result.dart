import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TajwidTestResult extends Equatable {
  const TajwidTestResult({
    required this.tajwidId,
    required this.tajwidName,
    required this.tajwidDescription,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
  });

  final String tajwidId;
  final String tajwidName;
  final String tajwidDescription;
  final double grade;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  List<Object?> get props => [tajwidId];
}
