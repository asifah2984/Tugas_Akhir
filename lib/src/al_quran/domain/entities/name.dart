import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';
import 'package:alquran_app/src/al_quran/domain/entities/transliteration.dart';
import 'package:equatable/equatable.dart';

class Name extends Equatable {
  const Name({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });

  final String short;
  final String long;
  final Transliteration transliteration;
  final Translation translation;

  @override
  List<Object?> get props => [short, long, transliteration, translation];
}
