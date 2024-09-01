import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TajwidQuestion extends Equatable {
  const TajwidQuestion({
    required this.id,
    required this.tajwidId,
    required this.question,
    required this.choices,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String tajwidId;
  final String question;
  final List<String> choices;
  final String answer;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  List<Object?> get props => [id, tajwidId];
}
