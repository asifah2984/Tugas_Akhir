import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditTajwidMaterial
    extends UseCaseWithParams<void, EditTajwidMaterialParams> {
  const EditTajwidMaterial(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(EditTajwidMaterialParams params) {
    return _repo.editTajwidMaterial(
      id: params.id,
      newContent: params.newContent,
    );
  }
}

class EditTajwidMaterialParams extends Equatable {
  const EditTajwidMaterialParams({
    required this.id,
    required this.newContent,
  });

  final String id;
  final String newContent;

  @override
  List<Object?> get props => [id, newContent];
}
