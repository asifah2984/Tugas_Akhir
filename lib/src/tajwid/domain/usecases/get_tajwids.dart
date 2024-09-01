import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTajwids extends UseCaseWithoutParams<List<Tajwid>> {
  const GetTajwids(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<List<Tajwid>> call() {
    return _repo.getTajwids();
  }
}
