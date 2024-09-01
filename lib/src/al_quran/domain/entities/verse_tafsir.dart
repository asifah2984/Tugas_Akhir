import 'package:alquran_app/src/al_quran/domain/entities/id.dart';
import 'package:equatable/equatable.dart';

class VerseTafsir extends Equatable {
  const VerseTafsir({
    required this.id,
  });

  final Id id;

  @override
  List<Object?> get props => [id];
}
