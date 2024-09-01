import 'package:alquran_app/src/al_quran/domain/entities/transliteration.dart';
import 'package:equatable/equatable.dart';

class Text extends Equatable {
  const Text({
    required this.arab,
    required this.transliteration,
  });

  final String arab;
  final Transliteration transliteration;

  @override
  List<Object?> get props => [arab, transliteration];
}
