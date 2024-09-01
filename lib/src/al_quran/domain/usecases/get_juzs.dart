import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetJuzs extends UseCaseWithoutParams<List<Juz>> {
  const GetJuzs(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<List<Juz>> call() {
    return _repo.getJuzs();
  }
}
