part of 'audio_player_bloc.dart';

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.initial() = _Initial;

  const factory AudioPlayerState.audioPlaying({
    required String url,
  }) = _AudioPlaying;

  const factory AudioPlayerState.audioPaused({
    required String url,
  }) = _AudioPaused;

  const factory AudioPlayerState.audioError({
    required String message,
  }) = _AudioError;
}
