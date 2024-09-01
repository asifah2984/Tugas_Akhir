import 'package:alquran_app/core/env/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class HttpClient {
  const HttpClient._();

  /// Instance of [HttpClient] from [Dio].
  static Dio get instance {
    final dio = Dio(_options)..interceptors.add(_requestInterceptor);

    // only log network request when in debug mode
    if (kDebugMode) dio.interceptors.add(_loggerInterceptor);

    return dio;
  }

  /// Base options for [Dio].
  static BaseOptions get _options => BaseOptions(
        baseUrl: Env.baseUrl,
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          Headers.acceptHeader: Headers.jsonContentType,
        },
      );

  static Interceptor get _requestInterceptor => RequestInterceptor();

  static Interceptor get _loggerInterceptor => TalkerDioLogger();
}

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = options.extra['accessToken'] as String?;

    if (accessToken != null) {
      options.headers.addAll({'authorization': 'Bearer $accessToken'});
    }

    super.onRequest(options, handler);
  }
}
