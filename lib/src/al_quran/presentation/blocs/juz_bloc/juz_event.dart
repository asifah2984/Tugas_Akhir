part of 'juz_bloc.dart';

@freezed
class JuzEvent with _$JuzEvent {
  const factory JuzEvent.started() = _Started;

  const factory JuzEvent.getJuzsEvent() = _GetJuzsEvent;

  const factory JuzEvent.getJuzEvent({
    required int juz,
  }) = _GetJuzEvent;
}
