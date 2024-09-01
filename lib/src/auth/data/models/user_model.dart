import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  LocalUserModel({
    required super.id,
    required super.name,
    required super.email,
    super.isAdmin,
  });

  factory LocalUserModel.empty() {
    return LocalUserModel(
      id: '__id__',
      name: '__name__',
      email: '__email__',
    );
  }

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source) as DataMap);

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String? ?? '',
      isAdmin: map['isAdmin'] as bool? ?? false,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  String toJson() => json.encode(toMap());

  LocalUserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
  }) {
    return LocalUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  String toString() {
    return 'LocalUserModel(id: $id, name: $name, email: $email, '
        'isAdmin: $isAdmin)';
  }
}
