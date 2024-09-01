import 'package:alquran_app/src/al_quran/domain/entities/surah.dart';
import 'package:alquran_app/src/al_quran/domain/entities/surah_detail.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_surah_detail.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_surahs.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'surah_event.dart';
part 'surah_state.dart';
part 'surah_bloc.freezed.dart';

@injectable
class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc({
    required GetSurahs getSurahs,
    required GetSurahDetail getSurahDetail,
  })  : _getSurahs = getSurahs,
        _getSurahDetail = getSurahDetail,
        super(const _Initial()) {
    on<_GetSurahsEvent>(_getSurahsHandler);
    on<_GetSurahDetailEvent>(_getSurahDetailHandler);
  }

  final GetSurahs _getSurahs;
  final GetSurahDetail _getSurahDetail;

  List<Surah>? _surahs;

  List<Surah>? get surahs => _surahs;

  Future<void> _getSurahsHandler(
    _GetSurahsEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(const _GettingSurahs());

    final result = await _getSurahs();

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetSurahsFailed(message: failure.errorMessage)),
      (surahs) {
        _surahs = surahs;
        emit(_SurahsLoaded(surahs: surahs));
      },
    );
  }

  Future<void> _getSurahDetailHandler(
    _GetSurahDetailEvent event,
    Emitter<SurahState> emit,
  ) async {
    emit(const _GettingSurahDetail());

    final result = await _getSurahDetail(
      GetSurahDetailParams(
        number: event.number,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetSurahDetailFailed(message: failure.errorMessage)),
      (surahDetail) {
        emit(_SurahDetailLoaded(surahDetail: surahDetail));
      },
    );
  }
}
