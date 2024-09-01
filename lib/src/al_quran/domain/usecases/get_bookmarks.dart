import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBookmarks
    extends UseCaseWithParams<List<Bookmark>, GetBookmarksParams> {
  const GetBookmarks(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<List<Bookmark>> call(GetBookmarksParams params) {
    return _repo.getBookmarks(
      userId: params.userId,
    );
  }
}

class GetBookmarksParams extends Equatable {
  const GetBookmarksParams({
    required this.userId,
  });

  final String userId;

  @override
  List<Object?> get props => [userId];
}
