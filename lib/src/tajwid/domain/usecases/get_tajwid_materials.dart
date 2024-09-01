import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/entities/tajwid_material.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTajwidMaterials
    extends UseCaseWithParams<List<TajwidMaterial>, GetTajwidMaterialsParams> {
  const GetTajwidMaterials(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<List<TajwidMaterial>> call(GetTajwidMaterialsParams params) {
    return _repo.getTajwidMaterials(
      tajwidId: params.tajwidId,
    );
  }
}

class GetTajwidMaterialsParams extends Equatable {
  const GetTajwidMaterialsParams({
    required this.tajwidId,
  });

  final String tajwidId;

  @override
  List<Object?> get props => [tajwidId];
}
