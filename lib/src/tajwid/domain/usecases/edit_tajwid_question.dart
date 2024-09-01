import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditTajwidQuestion
    extends UseCaseWithParams<void, EditTajwidQuestionParams> {
  const EditTajwidQuestion(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(EditTajwidQuestionParams params) {
    return _repo.editTajwidQuestion(
      id: params.id,
      newQuestion: params.newQuestion,
      newChoices: params.newChoices,
      newAnswer: params.newAnswer,
    );
  }
}

class EditTajwidQuestionParams extends Equatable {
  const EditTajwidQuestionParams({
    required this.id,
    required this.newQuestion,
    required this.newChoices,
    required this.newAnswer,
  });

  final String id;
  final String newQuestion;
  final List<String> newChoices;
  final String newAnswer;

  @override
  List<Object?> get props => [
        id,
        newQuestion,
        newChoices,
        newAnswer,
      ];
}
