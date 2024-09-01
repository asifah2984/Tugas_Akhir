import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:equatable/equatable.dart';

class Juz extends Equatable {
  const Juz({
    required this.juz,
    required this.juzStartSurahNumber,
    required this.juzEndSurahNumber,
    required this.juzStartInfo,
    required this.juzEndInfo,
    required this.totalVerses,
    required this.verses,
  });

  final int juz;
  final int juzStartSurahNumber;
  final int juzEndSurahNumber;
  final String juzStartInfo;
  final String juzEndInfo;
  final int totalVerses;
  final List<Verse> verses;

  @override
  List<Object?> get props => [
        juz,
        juzStartSurahNumber,
        juzEndSurahNumber,
        juzStartInfo,
        juzEndInfo,
        totalVerses,
        verses,
      ];
}
