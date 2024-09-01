import 'package:alquran_app/src/al_quran/domain/entities/audio.dart';
import 'package:alquran_app/src/al_quran/domain/entities/text.dart';
import 'package:alquran_app/src/al_quran/domain/entities/translation.dart';
import 'package:equatable/equatable.dart';

class PreBismillah extends Equatable {
  const PreBismillah({
    required this.text,
    required this.translation,
    required this.audio,
  });

  final Text text;
  final Translation translation;
  final Audio audio;

  @override
  List<Object?> get props => [text, translation, audio];
}
