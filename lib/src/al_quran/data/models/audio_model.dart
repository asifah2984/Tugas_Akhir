import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/audio.dart';
import 'package:flutter/widgets.dart';

class AudioModel extends Audio {
  const AudioModel({
    required super.primary,
    required super.secondary,
  });

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      primary: map['primary'] as String,
      secondary: List<String>.from(map['secondary'] as Iterable<dynamic>),
    );
  }

  factory AudioModel.fromJson(String source) =>
      AudioModel.fromMap(json.decode(source) as DataMap);

  @override
  List<Object?> get props => [primary, secondary];

  AudioModel copyWith({
    String? primary,
    ValueGetter<List<String>?>? secondary,
  }) {
    return AudioModel(
      primary: primary ?? this.primary,
      secondary: secondary != null ? secondary() : this.secondary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primary': primary,
      'secondary': secondary,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'AudioModel(primary: $primary, secondary: $secondary)';
}
