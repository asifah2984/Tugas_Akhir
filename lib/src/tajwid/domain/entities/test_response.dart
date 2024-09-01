import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TestResponse extends Equatable {
  const TestResponse({
    required this.id,
    required this.userId,
    required this.tajwidId,
    required this.answers,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String tajwidId;
  final Map<String, String> answers;
  final double grade;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  List<Object?> get props => [id, userId, tajwidId];
}
