import 'package:equatable/equatable.dart';

class Audio extends Equatable {
  const Audio({
    required this.primary,
    required this.secondary,
  });

  final String primary;
  final List<String>? secondary;

  @override
  List<Object?> get props => [primary, secondary];
}
