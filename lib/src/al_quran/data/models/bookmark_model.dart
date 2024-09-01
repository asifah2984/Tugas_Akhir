import 'dart:convert';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';

class BookmarkModel extends Bookmark {
  const BookmarkModel({
    required super.id,
    required super.type,
    required super.title,
    required super.ayah,
    required super.surahOrJuzId,
    required super.userId,
    super.isLastRead = 0,
  });

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'] as int,
      type: map['type'] as String,
      title: map['title'] as String,
      ayah: map['ayah'] as int,
      surahOrJuzId: map['surahOrJuzId'] as int,
      userId: map['userId'] as String,
      isLastRead: map['isLastRead'] as int,
    );
  }

  factory BookmarkModel.fromJson(String source) =>
      BookmarkModel.fromMap(json.decode(source) as DataMap);

  BookmarkModel copyWith({
    int? id,
    String? type,
    String? title,
    int? ayah,
    int? surahOrJuzId,
    String? userId,
    int? isLastRead,
  }) {
    return BookmarkModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      ayah: ayah ?? this.ayah,
      surahOrJuzId: surahOrJuzId ?? this.surahOrJuzId,
      userId: userId ?? this.userId,
      isLastRead: isLastRead ?? this.isLastRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'ayah': ayah,
      'surahOrJuzId': surahOrJuzId,
      'userId': userId,
      'isLastRead': isLastRead,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BookmarkModel(id: $id, type: $type, title: $title, ayah: $ayah, '
        'surahOrJuzId: $surahOrJuzId, userId: $userId, '
        'isLastRead: $isLastRead)';
  }
}
