import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_result.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTestResults
    extends UseCaseWithParams<List<TestResult>, GetTestResultsParams> {
  const GetTestResults(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<List<TestResult>> call(GetTestResultsParams params) {
    return _repo.getTestResults(
      tajwidId: params.tajwidId,
    );
  }
}

class GetTestResultsParams extends Equatable {
  const GetTestResultsParams({
    required this.tajwidId,
  });

  final String tajwidId;

  @override
  List<Object?> get props => [tajwidId];
}
