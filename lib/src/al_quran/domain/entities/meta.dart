import 'package:alquran_app/src/al_quran/domain/entities/sajda.dart';
import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  const Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  final int juz;
  final int page;
  final int manzil;
  final int ruku;
  final int hizbQuarter;
  final Sajda sajda;

  @override
  List<Object?> get props => [
        juz,
        page,
        manzil,
        ruku,
        hizbQuarter,
        sajda,
      ];
}
