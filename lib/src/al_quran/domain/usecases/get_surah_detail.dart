import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSurahDetail
    extends UseCaseWithParams<SurahDetail, GetSurahDetailParams> {
  GetSurahDetail(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<SurahDetail> call(GetSurahDetailParams params) {
    return _repo.getSurahDetail(
      number: params.number,
    );
  }
}

class GetSurahDetailParams extends Equatable {
  const GetSurahDetailParams({
    required this.number,
  });

  final int number;

  @override
  List<Object?> get props => [number];
}
