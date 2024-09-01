import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteTajwidMaterial
    extends UseCaseWithParams<void, DeleteTajwidMaterialParams> {
  const DeleteTajwidMaterial(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(DeleteTajwidMaterialParams params) {
    return _repo.deleteTajwidMaterial(
      id: params.id,
    );
  }
}

class DeleteTajwidMaterialParams extends Equatable {
  const DeleteTajwidMaterialParams({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
