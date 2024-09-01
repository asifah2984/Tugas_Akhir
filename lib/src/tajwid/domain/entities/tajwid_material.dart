import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TajwidMaterial extends Equatable {
  const TajwidMaterial({
    required this.id,
    required this.tajwidId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String tajwidId;
  final String content;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  List<Object?> get props => [id, tajwidId, content];
}
