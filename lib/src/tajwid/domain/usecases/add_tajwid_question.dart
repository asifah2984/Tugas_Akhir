import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddTajwidQuestion
    extends UseCaseWithParams<void, AddTajwidQuestionParams> {
  const AddTajwidQuestion(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(AddTajwidQuestionParams params) {
    return _repo.addTajwidQuestion(
      tajwidId: params.tajwidId,
      question: params.question,
      choices: params.choices,
      answer: params.answer,
    );
  }
}

class AddTajwidQuestionParams extends Equatable {
  const AddTajwidQuestionParams({
    required this.tajwidId,
    required this.question,
    required this.choices,
    required this.answer,
  });

  final String tajwidId;
  final String question;
  final List<String> choices;
  final String answer;

  @override
  List<Object?> get props => [
        tajwidId,
        question,
        choices,
        answer,
      ];
}
