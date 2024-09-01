import 'package:alquran_app/core/usecase/usecase.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/domain/entities/bookmark.dart';
import 'package:alquran_app/src/al_quran/domain/repos/al_quran_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLastRead extends UseCaseWithParams<Bookmark?, GetLastReadParams> {
  GetLastRead(this._repo);

  final AlQuranRepo _repo;

  @override
  ResultFuture<Bookmark?> call(GetLastReadParams params) {
    return _repo.getLastRead(
      userId: params.userId,
    );
  }
}

class GetLastReadParams extends Equatable {
  const GetLastReadParams({
    required this.userId,
  });

  final String userId;

  @override
  List<Object?> get props => [userId];
}
