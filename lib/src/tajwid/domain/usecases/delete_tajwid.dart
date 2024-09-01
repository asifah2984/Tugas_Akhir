import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteTajwid extends UseCaseWithParams<void, DeleteTajwidParams> {
  const DeleteTajwid(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(DeleteTajwidParams params) {
    return _repo.deleteTajwid(id: params.id);
  }
}

class DeleteTajwidParams extends Equatable {
  const DeleteTajwidParams({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
