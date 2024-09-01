// audio_player_event.dart
part of 'audio_player_bloc.dart';

@freezed
class AudioPlayerEvent with _$AudioPlayerEvent {
  const factory AudioPlayerEvent.playAudioEvent({
    required String url,
  }) = _PlayAudioEvent;

  const factory AudioPlayerEvent.stopAudioEvent() = _StopAudioEvent;
}
