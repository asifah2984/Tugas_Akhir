import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  const Bookmark({
    required this.type,
    required this.title,
    required this.ayah,
    required this.surahOrJuzId,
    required this.userId,
    this.id = 0,
    this.isLastRead = 0,
  });

  final int id;
  final String type;
  final String title;
  final int ayah;
  final int surahOrJuzId;
  final String userId;
  final int isLastRead;

  @override
  List<Object?> get props => [id, surahOrJuzId];
}
