import 'package:equatable/equatable.dart';

class LocalUser with EquatableMixin {
  const LocalUser({
    required this.id,
    required this.name,
    required this.email,
    this.isAdmin = false,
  });

  final String id;
  final String name;
  final String email;
  final bool isAdmin;

  @override
  List<Object?> get props => [id];
}
