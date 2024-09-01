import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/pair.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_question.dart';
import 'package:alquran_app/src/tajwid/domain/entities/test_response.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTestResult extends UseCaseWithParams<
    Pair<List<TajwidQuestion>?, TestResponse?>, GetTestResultParams> {
  const GetTestResult(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<Pair<List<TajwidQuestion>, TestResponse?>> call(
    GetTestResultParams params,
  ) {
    return _repo.getTestResult(
      tajwidId: params.tajwidId,
      userId: params.userId,
    );
  }
}

class GetTestResultParams extends Equatable {
  const GetTestResultParams({
    required this.tajwidId,
    this.userId,
  });

  final String tajwidId;
  final String? userId;

  @override
  List<Object?> get props => [tajwidId];
}
