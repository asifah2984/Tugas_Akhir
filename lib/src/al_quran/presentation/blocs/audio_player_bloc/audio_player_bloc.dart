import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'audio_player_bloc.freezed.dart';
part 'audio_player_event.dart';
part 'audio_player_state.dart';

@injectable
class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc({
    required AudioPlayer audioPlayer,
  })  : _audioPlayer = audioPlayer,
        super(const AudioPlayerState.initial()) {
    on<_PlayAudioEvent>(_playAudioHandler);
    on<_StopAudioEvent>(_stopAudioHandler);

    _audioPlayer.onPlayerComplete.listen((event) {
      add(const AudioPlayerEvent.stopAudioEvent());
    });
  }

  final AudioPlayer _audioPlayer;

  Future<void> _playAudioHandler(
    _PlayAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      if (state is _AudioPlaying && (state as _AudioPlaying).url == event.url) {
        await _audioPlayer.pause();
        emit(AudioPlayerState.audioPaused(url: event.url));
      } else {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(event.url));
        emit(AudioPlayerState.audioPlaying(url: event.url));
      }
    } catch (e) {
      emit(AudioPlayerState.audioError(message: e.toString()));
    }
  }

  Future<void> _stopAudioHandler(
    _StopAudioEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      await _audioPlayer.stop();
      emit(const AudioPlayerState.initial());
    } catch (e) {
      emit(AudioPlayerState.audioError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
