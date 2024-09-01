part of 'juz_bloc.dart';

@freezed
class JuzState with _$JuzState {
  const factory JuzState.initial() = _Initial;

  const factory JuzState.gettingJuzs() = _GettingJuzs;

  const factory JuzState.juzsLoaded({
    required List<Juz> juzs,
  }) = _JuzsLoaded;

  const factory JuzState.getJuzsFailed({
    required String message,
  }) = _GetJuzsFailed;

  const factory JuzState.gettingJuz() = _GettingJuz;

  const factory JuzState.juzLoaded({
    required Juz juz,
  }) = _JuzLoaded;

  const factory JuzState.getJuzFailed({
    required String message,
  }) = _GetJuzFailed;
}
