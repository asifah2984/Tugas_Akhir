import 'package:equatable/equatable.dart';

class Translation extends Equatable {
  const Translation({
    required this.en,
    required this.id,
  });

  final String en;
  final String id;

  @override
  List<Object?> get props => [en, id];
}
