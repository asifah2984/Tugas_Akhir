part of 'surah_bloc.dart';

@freezed
class SurahState with _$SurahState {
  const factory SurahState.initial() = _Initial;

  const factory SurahState.gettingSurahs() = _GettingSurahs;

  const factory SurahState.surahsLoaded({
    required List<Surah> surahs,
  }) = _SurahsLoaded;

  const factory SurahState.getSurahsFailed({
    required String message,
  }) = _GetSurahsFailed;

  const factory SurahState.gettingSurahDetail() = _GettingSurahDetail;

  const factory SurahState.surahDetailLoaded({
    required SurahDetail surahDetail,
  }) = _SurahDetailLoaded;

  const factory SurahState.getSurahDetailFailed({
    required String message,
  }) = _GetSurahDetailFailed;
}
