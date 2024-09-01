import 'package:alquran_app/core/utils/typedef.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// [GeneralException]
///
/// Takes [message] description to forms
/// a throwable [GeneralException] for developer-defined error-handling.
///
/// ```dart
/// try {
///   ...
/// } catch (e) {
///   throw GeneralException(
///     message: 'An unknown error occurred',
///   );
/// }
/// ```
class GeneralException extends Equatable implements Exception {
  const GeneralException({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

/// [CacheException]
///
/// Takes required [message] description to forms
/// a throwable [CacheException] for cache-related error-handling
///
/// ```dart
/// try {
///   ...
/// } catch (e) {
///   throw CacheException(
///     message: e.toString(),
///   );
/// }
/// ```
class CacheException extends Equatable implements Exception {
  const CacheException({
    required this.message,
    this.prefix = 'Cache Exception',
  });

  final String message;
  final String prefix;

  @override
  List<Object?> get props => [message, prefix];
}

/// [ClientException]
///
/// Throw when there is an error occured on the client side,
/// such as inactive internet connection or a platform exception.
/// [message] can be generated from exception's stack trace.
///
/// ```dart
/// try {
///   ...
/// } on http.ClientException catch (e) {
///   throw ClientException(
///     message: 'A client error occurred',
///   );
/// }
/// ```
class ClientException extends Equatable implements Exception {
  const ClientException({
    required this.message,
    this.prefix = 'Client-Side Error',
  });

  final String prefix;
  final String message;

  @override
  List<Object?> get props => [prefix, message];
}

/// [ServerException]
///
/// Takes [message] description and HTTP [statusCode] to
/// forms a throwable [ServerException] for API-related error-handling.
///
/// ```dart
/// try {
///   final response = await http.get(...);
///   ...
///   if (response.statusCode != 200 || response.statusCode != 201) {
///     throw ServerException(
///       message: response.body,
///       statusCode: response.statusCode,
///     );
///   }
/// } on ServerException {
///   rethrow;
/// }
/// ```
class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.statusCode,
    required this.message,
  });

  factory ServerException.fromDio(DioException exception) {
    int? statusCode;
    String? message;

    switch (exception.type) {
      case DioExceptionType.connectionError:
        statusCode = 503;
        message = exception.error.toString();
      case DioExceptionType.connectionTimeout:
        statusCode = 504;
        message = 'Connection timed out';
      case DioExceptionType.cancel:
        statusCode = 499;
        message = 'Request to API server was cancelled';
      case DioExceptionType.sendTimeout:
        statusCode = 408;
        message = 'Send timeout error';
      case DioExceptionType.receiveTimeout:
        statusCode = 504;
        message = 'Receive timeout error';
      case DioExceptionType.badCertificate:
        statusCode = 495;
        message = 'Bad certificate error';
      case DioExceptionType.badResponse:
        statusCode = exception.response?.statusCode ?? 500;
        try {
          message = message ??=
              (exception.response?.data as DataMap?)?['message'] as String? ??
                  'Oops, something went wrong. Please try again later';
        } catch (e) {
          message = 'Oops, something went wrong. Please try again later';
        }
      case DioExceptionType.unknown:
        statusCode = 520;
        message = 'Oops, something went wrong. Please try again later';
    }

    return ServerException(
      statusCode: statusCode.toString(),
      message: message,
    );
  }

  factory ServerException.fromFirebaseAuthSignUp(String code) {
    late final String message;
    switch (code) {
      case 'invalid-email':
        message = 'Email is not valid or badly formatted.';
      case 'user-disabled':
        message =
            'This user has been disabled. Please contact support for help.';
      case 'email-already-in-use':
        message = 'An account already exists for that email.';
      case 'operation-not-allowed':
        message = 'Operation is not allowed.  Please contact support.';
      case 'weak-password':
        message = 'Please enter a stronger password.';
      default:
        message = 'An unknown exception occurred';
    }

    return ServerException(statusCode: code, message: message);
  }

  factory ServerException.fromFirebaseAuthSignIn(String code) {
    late final String message;

    switch (code) {
      case 'invalid-email':
        message = 'Email is not valid or badly formatted.';
      case 'user-disabled':
        message =
            'This user has been disabled. Please contact support for help.';
      case 'user-not-found':
        message = 'Email is not found, please create an account.';
      case 'wrong-password':
        message = 'Incorrect password, please try again.';
      default:
        message = 'An unknown exception occurred.';
    }

    return ServerException(statusCode: code, message: message);
  }

  final String statusCode;
  final String message;

  @override
  List<Object?> get props => [message, statusCode];
}
