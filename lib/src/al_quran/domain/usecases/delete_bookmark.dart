import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteBookmark extends UseCaseWithParams<void, DeleteBookmarkParams> {
  const DeleteBookmark(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<void> call(DeleteBookmarkParams params) {
    return _repo.deleteBookmark(id: params.id);
  }
}

class DeleteBookmarkParams extends Equatable {
  const DeleteBookmarkParams({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
