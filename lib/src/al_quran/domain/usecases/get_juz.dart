import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetJuz extends UseCaseWithParams<Juz, GetJuzParams> {
  const GetJuz(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<Juz> call(GetJuzParams params) {
    return _repo.getJuz(
      juz: params.juz,
    );
  }
}

class GetJuzParams extends Equatable {
  const GetJuzParams({
    required this.juz,
  });

  final int juz;

  @override
  List<Object?> get props => [juz];
}
