import 'package:equatable/equatable.dart';

class Number extends Equatable {
  const Number({
    required this.inQuran,
    required this.inSurah,
  });

  final int inQuran;
  final int inSurah;

  @override
  List<Object?> get props => [inQuran, inSurah];
}
