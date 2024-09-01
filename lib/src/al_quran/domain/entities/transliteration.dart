import 'package:equatable/equatable.dart';

class Transliteration extends Equatable {
  const Transliteration({
    required this.en,
    this.id,
  });

  final String en;
  final String? id;

  @override
  List<Object?> get props => [en, id];
}
