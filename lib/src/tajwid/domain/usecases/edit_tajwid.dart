import 'dart:io';

import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditTajwid extends UseCaseWithParams<void, EditTajwidParams> {
  const EditTajwid(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(EditTajwidParams params) {
    return _repo.editTajwid(
      id: params.id,
      newTajwidName: params.newTajwidName,
      newTajwidDescription: params.newTajwidDescription,
      newThumbnailImage: params.newThumbnailImage,
    );
  }
}

class EditTajwidParams extends Equatable {
  const EditTajwidParams({
    required this.id,
    required this.newTajwidName,
    required this.newTajwidDescription,
    required this.newThumbnailImage,
  });

  final String id;
  final String? newTajwidName;
  final String? newTajwidDescription;
  final File? newThumbnailImage;

  @override
  List<Object?> get props => [id, newTajwidName, newThumbnailImage];
}
