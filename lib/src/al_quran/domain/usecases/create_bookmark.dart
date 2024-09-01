import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateBookmark extends UseCaseWithParams<void, CreateBookmarkParams> {
  const CreateBookmark(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<void> call(CreateBookmarkParams params) {
    return _repo.createBookmark(
      bookmark: params.bookmark,
    );
  }
}

class CreateBookmarkParams extends Equatable {
  const CreateBookmarkParams({
    required this.bookmark,
  });

  final Bookmark bookmark;

  @override
  List<Object?> get props => [bookmark];
}
