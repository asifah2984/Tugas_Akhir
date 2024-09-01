part of 'surah_bloc.dart';

@freezed
class SurahEvent with _$SurahEvent {
  const factory SurahEvent.getSurahsEvent() = _GetSurahsEvent;

  const factory SurahEvent.getSurahDetailEvent({
    required int number,
  }) = _GetSurahDetailEvent;
}
