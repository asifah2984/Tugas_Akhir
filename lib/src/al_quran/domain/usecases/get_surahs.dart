import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSurahs extends UseCaseWithoutParams<List<Surah>> {
  const GetSurahs(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<List<Surah>> call() {
    return _repo.getSurahs();
  }
}
