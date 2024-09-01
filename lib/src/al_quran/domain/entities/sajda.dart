import 'package:equatable/equatable.dart';

class Sajda extends Equatable {
  const Sajda({
    required this.recommended,
    required this.obligatory,
  });

  final bool recommended;
  final bool obligatory;

  @override
  List<Object?> get props => [recommended, obligatory];
}
