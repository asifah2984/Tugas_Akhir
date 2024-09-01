import 'dart:async';
import 'dart:convert';
import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/bookmark_model.dart';
import 'package:alquran_app/src/al_quran/data/models/juz_model.dart';
import 'package:alquran_app/src/al_quran/data/models/verse_model.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class AlQuranLocalDataSource {
  Future<void> insertJuz(JuzModel juz);

  Future<List<JuzModel>> getJuzs();

  Future<JuzModel> getJuz(int juz);

  Future<void> insertBookmark(Bookmark bookmark);

  Future<List<BookmarkModel>> getBookmarks(String userId);

  Future<void> deleteBookmark(int id);
  
  Future<Bookmark?> getLastRead(String userId);
}

@LazySingleton(as: AlQuranLocalDataSource)
class AlQuranLocalDataSourceImpl implements AlQuranLocalDataSource{
  const AlQuranLocalDataSourceImpl ({
    required Database localDbClient,
  }) : _localDbClient = localDbClient;

  final Database _localDbClient;

  @override
  Future<void> insertJuz(JuzModel juz) async {
    final db = _localDbClient;
    await db.insert(
      'juzs',
      {
        'juz': juz.juz,
        'juzStartSurahNumber': juz.juzStartSurahNumber,
        'juzEndSurahNumber': juz.juzEndSurahNumber,
        'juzStartInfo': juz.juzStartInfo,
        'juzEndInfo': juz.juzEndInfo,
        'totalVerses': juz.totalVerses,
        'verses': jsonEncode(
          juz.verses.map((v) => (v as VerseModel).toMap()).toList(),
        ),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<JuzModel>> getJuzs() async {
    final db = _localDbClient;
    final List<DataMap> maps = await db.query('juzs');

    return List.generate(maps.length, (index) {
      return JuzModel(
        juz: maps[index]['juz'] as int,
        juzStartSurahNumber: maps[index]['juzStartSurahNumber'] as int,
        juzEndSurahNumber: maps[index]['juzEndSurahNumber'] as int,
        juzStartInfo: maps[index]['juzStartInfo'] as String,
        juzEndInfo: maps[index]['juzEndInfo'] as String,
        totalVerses: maps[index]['totalVerses'] as int,
        verses: (jsonDecode(maps[index]['verses'] as String) as List<dynamic>)
            .map((v) => VerseModel.fromMap(v as DataMap))
            .toList(),
      );
    });
  }

  @override
  Future<JuzModel> getJuz(int juz) async {
    try {
      final db = _localDbClient;
      final List<DataMap> maps = await db.query(
        'juzs',
        where: 'juz = ?',
        whereArgs: [juz],
      );

      if (maps.isEmpty) {
        throw const ClientException(message: 'Juz not found');
      }

      final map = maps.first;
      return JuzModel(
        juz: map['juz'] as int,
        juzStartSurahNumber: map['juzStartSurahNumber'] as int,
        juzEndSurahNumber: map['juzEndSurahNumber'] as int,
        juzStartInfo: map['juzStartInfo'] as String,
        juzEndInfo: map['juzEndInfo'] as String,
        totalVerses: map['totalVerses'] as int,
        verses: (jsonDecode(map['verses'] as String) as List<dynamic>)
            .map((v) => VerseModel.fromMap(v as DataMap))
            .toList(),
      );
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }

  @override
  Future<void> insertBookmark(Bookmark bookmark) async {
    try {
      final db = _localDbClient;

      // Check if the bookmark already exists for the given criteria
      final existingBookmarks = await db.query(
        'bookmarks',
        where:
            // ignore: lines_longer_than_80_chars
            'userId = ? AND type = ? AND surahOrJuzId = ? AND title = ? AND ayah = ? AND isLastRead = ?',
        whereArgs: [
          bookmark.userId,
          bookmark.type,
          bookmark.surahOrJuzId,
          bookmark.title,
          bookmark.ayah,
          1,
        ],
      );

      if (existingBookmarks.isNotEmpty) {
        throw const ClientException(message: 'Bookmark already exists');
      }

      await db.insert(
        'bookmarks',
        {
          'type': bookmark.type,
          'title': bookmark.title,
          'ayah': bookmark.ayah,
          'surahOrJuzId': bookmark.surahOrJuzId,
          'userId': bookmark.userId,
          'isLastRead': bookmark.isLastRead,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }

  @override
  Future<List<BookmarkModel>> getBookmarks(String userId) async {
    try {
      final db = _localDbClient;
      final List<DataMap> maps = await db.query(
        'bookmarks',
        where: 'userId = ? AND isLastRead = ?',
        whereArgs: [userId, 0],
      );

      return List.generate(maps.length, (index) {
        return BookmarkModel(
          id: maps[index]['id'] as int,
          type: maps[index]['type'] as String,
          title: maps[index]['title'] as String,
          ayah: maps[index]['ayah'] as int,
          surahOrJuzId: maps[index]['surahOrJuzId'] as int,
          userId: maps[index]['userId'] as String,
          isLastRead: maps[index]['isLastRead'] as int,
        );
      });
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }

  @override
  Future<void> deleteBookmark(int id) async {
    try {
      final db = _localDbClient;
      final rowsDeleted = await db.delete(
        'bookmarks',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rowsDeleted == 0) {
        throw const ClientException(message: 'Bookmark not found');
      }
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }

  @override
  Future<Bookmark?> getLastRead(String userId) async {
    try {
      final db = _localDbClient;
      final List<DataMap> maps = await db.query(
        'bookmarks',
        where: 'isLastRead = ? AND userId = ?',
        whereArgs: [1, userId],
        orderBy: 'id DESC',
        limit: 1,
      );

      if (maps.isEmpty) return null;

      final map = maps.first;
      return BookmarkModel(
        id: map['id'] as int,
        type: map['type'] as String,
        title: map['title'] as String,
        ayah: map['ayah'] as int,
        surahOrJuzId: map['surahOrJuzId'] as int,
        userId: map['userId'] as String,
        isLastRead: map['isLastRead'] as int,
      );
    } catch (e) {
      throw ClientException(message: e.toString());
    }
  }

  Future<void> close() async {
    final db = _localDbClient;
    await db.close();
  }
}
