import 'package:equatable/equatable.dart';

class Tafsir extends Equatable {
  const Tafsir({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
