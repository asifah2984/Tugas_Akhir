import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/profile/domain/entities/tajwid_test_result.dart';

abstract class ProfileRepo {
  ResultFuture<List<TajwidTestResult>> getTajwidTestResults();
}
