import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitTest extends UseCaseWithParams<void, SubmitTestParams> {
  const SubmitTest(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(SubmitTestParams params) {
    return _repo.submitTest(
      tajwidId: params.tajwidId,
      answers: params.answers,
    );
  }
}

class SubmitTestParams extends Equatable {
  const SubmitTestParams({
    required this.tajwidId,
    required this.answers,
  });

  final String tajwidId;
  final Map<String, String> answers;

  @override
  List<Object?> get props => [tajwidId, answers];
}
