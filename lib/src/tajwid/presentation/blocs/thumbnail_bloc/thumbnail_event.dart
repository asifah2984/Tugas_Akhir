part of 'thumbnail_bloc.dart';

@freezed
class ThumbnailEvent with _$ThumbnailEvent {
  const factory ThumbnailEvent.pickThumbnailImageEvent() =
      _PickThumbnailImageEvent;
}
