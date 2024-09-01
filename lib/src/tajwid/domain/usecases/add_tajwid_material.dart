import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddTajwidMaterial
    extends UseCaseWithParams<void, AddTajwidMaterialParams> {
  const AddTajwidMaterial(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(AddTajwidMaterialParams params) {
    return _repo.addTajwidMaterial(
      tajwidId: params.tajwidId,
      content: params.content,
    );
  }
}

class AddTajwidMaterialParams extends Equatable {
  const AddTajwidMaterialParams({
    required this.tajwidId,
    required this.content,
  });

  final String tajwidId;
  final String content;

  @override
  List<Object?> get props => [tajwidId, content];
}
