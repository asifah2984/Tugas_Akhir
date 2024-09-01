import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TestResult extends Equatable {
  const TestResult({
    required this.userId,
    required this.tajwidId,
    required this.userName,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
    this.userEmail,
  });

  final String userId;
  final String tajwidId;
  final String userName;
  final double grade;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String? userEmail;

  @override
  List<Object?> get props => [userId, tajwidId];
}
