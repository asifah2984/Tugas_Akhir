part of 'thumbnail_bloc.dart';

@freezed
class ThumbnailState with _$ThumbnailState {
  const factory ThumbnailState.initial() = _Initial;

  const factory ThumbnailState.pickingThumbnailImage() = _PickingThumbnailImage;

  const factory ThumbnailState.thumbnailImagePicked({
    required File? imageFile,
  }) = _ThumbnailImagePicked;

  const factory ThumbnailState.pickThumbnailImageFailed({
    required String message,
  }) = _PickThumbnailImageFailed;
}
