import 'package:alquran_app/src/al_quran/domain/entities/juz.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_juz.dart';
import 'package:alquran_app/src/al_quran/domain/usecases/get_juzs.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'juz_event.dart';
part 'juz_state.dart';
part 'juz_bloc.freezed.dart';

@injectable
class JuzBloc extends Bloc<JuzEvent, JuzState> {
  JuzBloc({
    required GetJuzs getJuzs,
    required GetJuz getJuz,
  })  : _getJuzs = getJuzs,
        _getJuz = getJuz,
        super(const _Initial()) {
    on<_GetJuzsEvent>(_getJuzsHandler);
    on<_GetJuzEvent>(_getJuzHandler);
  }

  final GetJuzs _getJuzs;
  final GetJuz _getJuz;

  List<Juz>? _juzs;

  List<Juz>? get juzs => _juzs;

  Future<void> _getJuzsHandler(
    _GetJuzsEvent event,
    Emitter<JuzState> emit,
  ) async {
    emit(const _GettingJuzs());

    final result = await _getJuzs();

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetJuzsFailed(message: failure.errorMessage)),
      (juzs) {
        _juzs = juzs;
        emit(_JuzsLoaded(juzs: juzs));
      },
    );
  }

  Future<void> _getJuzHandler(
    _GetJuzEvent event,
    Emitter<JuzState> emit,
  ) async {
    emit(const _GettingJuz());

    final result = await _getJuz(
      GetJuzParams(juz: event.juz),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(_GetJuzFailed(message: failure.errorMessage)),
      (juz) => emit(_JuzLoaded(juz: juz)),
    );
  }
}
