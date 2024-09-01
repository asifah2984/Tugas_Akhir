import 'package:alquran_app/src/al_quran/domain/entities/name.dart';
import 'package:alquran_app/src/al_quran/domain/entities/revelation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/tafsir.dart';
import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  const Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
  });

  final int number;
  final int sequence;
  final int numberOfVerses;
  final Name name;
  final Revelation revelation;
  final Tafsir tafsir;

  @override
  List<Object?> get props => [
        number,
        sequence,
        numberOfVerses,
        name,
        revelation,
        tafsir,
      ];
}
