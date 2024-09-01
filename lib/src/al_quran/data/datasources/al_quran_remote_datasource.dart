import 'dart:convert';

import 'package:alquran_app/core/errors/exceptions.dart';
import 'package:alquran_app/core/utils/constants.dart';
import 'package:alquran_app/core/utils/typedef.dart';
import 'package:alquran_app/src/al_quran/data/models/juz_model.dart';
import 'package:alquran_app/src/al_quran/data/models/surah_detail_model.dart';
import 'package:alquran_app/src/al_quran/data/models/surah_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AlQuranRemoteDataSource {
  Future<List<SurahModel>> getSurahs();

  Future<SurahDetailModel> getSurahDetail({
    required int number,
  });

  Future<List<JuzModel>> getJuzs();
}

@LazySingleton(as: AlQuranRemoteDataSource)
class AlQuranRemoteDataSourceImpl implements AlQuranRemoteDataSource {
  AlQuranRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<SurahModel>> getSurahs() async {
    try {
      const path = '/surah';

      final response = await _dio.get<String>(path);
      final responseData = json.decode(response.data!) as DataMap;

      final surahsMap = responseData['data'] as List<dynamic>;
      final surahs =
          surahsMap.map((data) => SurahModel.fromMap(data as DataMap)).toList();

      return surahs;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<SurahDetailModel> getSurahDetail({
    required int number,
  }) async {
    try {
      final path = '/surah/$number';

      final response = await _dio.get<String>(path);

      final responseData = json.decode(response.data!) as DataMap;

      final surahDetailMap = responseData['data'] as DataMap;
      final surahDetail = SurahDetailModel.fromMap(surahDetailMap);

      return surahDetail;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }

  @override
  Future<List<JuzModel>> getJuzs() async {
    try {
      final juzs = <JuzModel>[];
      for (var i = 0; i < kTotalJuz; i++) {
        final path = '/juz/${i + 1}';
        final response = await _dio.get<String>(path);
        final responseData = json.decode(response.data!) as DataMap;

        final juzMap = responseData['data'] as DataMap;
        final juz = JuzModel.fromMap(juzMap);
        juzs.add(juz);

        // delay to avoid rate limiting
        await Future<void>.delayed(const Duration(milliseconds: 10000));
      }

      return juzs;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    } catch (e) {
      throw GeneralException(message: e.toString());
    }
  }
}
