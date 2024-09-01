import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';
import 'package:alquran_app/src/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTajwidTestResults
    extends UseCaseWithoutParams<List<TajwidTestResult>> {
  const GetTajwidTestResults(this._repo);

  final ProfileRepo _repo;

  @override
  ResultFuture<List<TajwidTestResult>> call() {
    return _repo.getTajwidTestResults();
  }
}
