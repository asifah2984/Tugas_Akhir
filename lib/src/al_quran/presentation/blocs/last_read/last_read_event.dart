part of 'last_read_bloc.dart';

@freezed
class LastReadEvent with _$LastReadEvent {
  const factory LastReadEvent.getLastReadEvent({
    required String userId,
  }) = _GetLastReadEvent;
}
