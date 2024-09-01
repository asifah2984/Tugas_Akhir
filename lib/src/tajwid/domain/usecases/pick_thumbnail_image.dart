import 'dart:io';

import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PickThumbnailImage extends UseCaseWithoutParams<File?> {
  const PickThumbnailImage(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<File?> call() {
    return _repo.pickThumbnailImage();
  }
}
