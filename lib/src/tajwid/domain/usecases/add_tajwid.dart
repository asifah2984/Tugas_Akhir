import 'dart:io';

import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddTajwid extends UseCaseWithParams<void, AddTajwidParams> {
  const AddTajwid(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(AddTajwidParams params) {
    return _repo.addTajwid(
      tajwidDescription: params.tajwidDescription,
      tajwidName: params.tajwidName,
      thumbnailImage: params.thumbnailImage,
    );
  }
}

class AddTajwidParams extends Equatable {
  const AddTajwidParams({
    required this.tajwidName,
    required this.tajwidDescription,  
    required this.thumbnailImage,
  });

  final String tajwidName;
  final String tajwidDescription;
  final File thumbnailImage;

  @override
  List<Object?> get props => [tajwidName, tajwidDescription, thumbnailImage];
}
