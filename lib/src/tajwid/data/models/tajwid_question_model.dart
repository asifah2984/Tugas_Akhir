import 'dart:convert';

import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TajwidQuestionModel extends TajwidQuestion {
  const TajwidQuestionModel({
    required super.id,
    required super.tajwidId,
    required super.question,
    required super.choices,
    required super.answer,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TajwidQuestionModel.fromMap(DataMap map) {
    return TajwidQuestionModel(
      id: map['id'] as String,
      tajwidId: map['tajwidId'] as String,
      question: map['question'] as String,
      choices: List<String>.from(map['choices'] as Iterable<dynamic>),
      answer: map['answer'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  factory TajwidQuestionModel.fromJson(String source) =>
      TajwidQuestionModel.fromMap(json.decode(source) as DataMap);

  TajwidQuestionModel copyWith({
    String? id,
    String? tajwidId,
    String? question,
    List<String>? choices,
    String? answer,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TajwidQuestionModel(
      id: id ?? this.id,
      tajwidId: tajwidId ?? this.tajwidId,
      question: question ?? this.question,
      choices: choices ?? this.choices,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'tajwidId': tajwidId,
      'question': question,
      'choices': choices,
      'answer': answer,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TajwidQuestionModel(id: $id, '
        'tajwidId: $tajwidId, question: $question, '
        'choices: $choices, answer: $answer, createdAt: $createdAt, '
        'updatedAt: $updatedAt)';
  }
}
