import 'package:equatable/equatable.dart';

class Revelation extends Equatable {
  const Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  final String arab;
  final String en;
  final String id;

  @override
  List<Object?> get props => [arab, en, id];
}
