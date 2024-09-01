import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Tajwid extends Equatable {
  const Tajwid({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  List<Object?> get props => [id];
}
