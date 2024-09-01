import 'package:alquran_app/src/al_quran/domain/entities/name.dart';
import 'package:alquran_app/src/al_quran/domain/entities/pre_bismillah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/revelation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/tafsir.dart';
import 'package:alquran_app/src/al_quran/domain/entities/verse.dart';
import 'package:equatable/equatable.dart';

class SurahDetail extends Equatable {
  const SurahDetail({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    required this.verses,
    this.preBismillah,
  });

  final int number;
  final int sequence;
  final int numberOfVerses;
  final Name name;
  final Revelation revelation;
  final Tafsir tafsir;
  final List<Verse> verses;
  final PreBismillah? preBismillah;

  @override
  List<Object?> get props => [
        number,
        sequence,
        numberOfVerses,
        name,
        revelation,
        tafsir,
        verses,
        preBismillah,
      ];
}
