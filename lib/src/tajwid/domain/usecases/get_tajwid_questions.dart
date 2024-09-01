import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTajwidQuestions
    extends UseCaseWithParams<List<TajwidQuestion>, GetTajwidQuestionsParams> {
  const GetTajwidQuestions(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<List<TajwidQuestion>> call(GetTajwidQuestionsParams params) {
    return _repo.getTajwidQuestions(
      tajwidId: params.tajwidId,
    );
  }
}

class GetTajwidQuestionsParams extends Equatable {
  const GetTajwidQuestionsParams({
    required this.tajwidId,
  });

  final String tajwidId;

  @override
  List<Object?> get props => [tajwidId];
}
