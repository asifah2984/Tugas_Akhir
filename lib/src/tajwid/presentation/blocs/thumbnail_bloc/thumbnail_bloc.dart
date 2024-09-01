import 'dart:io';

import 'package:alquran_app/src/tajwid/domain/usecases/pick_thumbnail_image.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'thumbnail_event.dart';
part 'thumbnail_state.dart';
part 'thumbnail_bloc.freezed.dart';

@injectable
class ThumbnailBloc extends Bloc<ThumbnailEvent, ThumbnailState> {
  ThumbnailBloc({
    required PickThumbnailImage pickThumbnailImage,
  })  : _pickThumbnailImage = pickThumbnailImage,
        super(const _Initial()) {
    on<_PickThumbnailImageEvent>(_pickThumbnailImageHandler);
  }

  final PickThumbnailImage _pickThumbnailImage;

  Future<void> _pickThumbnailImageHandler(
    _PickThumbnailImageEvent event,
    Emitter<ThumbnailState> emit,
  ) async {
    emit(const _PickingThumbnailImage());

    final result = await _pickThumbnailImage();

    result.fold(
      (failure) =>
          emit(_PickThumbnailImageFailed(message: failure.errorMessage)),
      (imageFile) => emit(_ThumbnailImagePicked(imageFile: imageFile)),
    );
  }
}
