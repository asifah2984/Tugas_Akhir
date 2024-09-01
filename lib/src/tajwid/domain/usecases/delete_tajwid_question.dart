import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/tajwid/domain/repos/tajwid_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteTajwidQuestion
    extends UseCaseWithParams<void, DeleteTajwidQuestionParams> {
  const DeleteTajwidQuestion(this._repo);

  final TajwidRepo _repo;

  @override
  ResultFuture<void> call(DeleteTajwidQuestionParams params) {
    return _repo.deleteTajwidQuestion(
      id: params.id,
    );
  }
}

class DeleteTajwidQuestionParams extends Equatable {
  const DeleteTajwidQuestionParams({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}
