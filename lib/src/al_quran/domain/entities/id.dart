import 'package:equatable/equatable.dart';

class Id extends Equatable {
  const Id({
    required this.short,
    required this.long,
  });

  final String short;
  final String long;

  @override
  List<Object?> get props => [short, long];
}
