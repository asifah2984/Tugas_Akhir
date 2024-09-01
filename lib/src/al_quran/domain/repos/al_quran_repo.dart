import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';

abstract class AlQuranRepo {
  ResultFuture<List<Surah>> getSurahs();

  ResultFuture<SurahDetail> getSurahDetail({
    required int number,
  });

  ResultFuture<List<Juz>> getJuzs();

  ResultFuture<Juz> getJuz({
    required int juz,
  });

  ResultFuture<List<Bookmark>> getBookmarks({
    required String userId,
  });

  ResultFuture<void> createBookmark({
    required Bookmark bookmark,
  });

  ResultFuture<void> deleteBookmark({
    required int id,
  });

  ResultFuture<Bookmark?> getLastRead({
    required String userId,
  });
}
