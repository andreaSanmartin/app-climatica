import 'package:dio/dio.dart';

/// Broad category of a failed request, used to tell a real connectivity
/// problem apart from a valid response the server rejected.
enum ApiExceptionType { connection, timeout, server, cancelled, unknown }

/// Application-level exception for any failure coming from the backend
/// or the network layer, with a message already safe to show to the user.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ApiExceptionType type;

  const ApiException(this.message, {this.statusCode, this.type = ApiExceptionType.unknown});

  bool get isConnectivityIssue =>
      type == ApiExceptionType.connection || type == ApiExceptionType.timeout;

  @override
  String toString() => message;
}

/// Converts a [DioException] into a friendly [ApiException].
ApiException mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const ApiException(
        'Tiempo de espera agotado. Verifique su conexión a internet.',
        type: ApiExceptionType.timeout,
      );
    case DioExceptionType.connectionError:
      return const ApiException(
        'Sin conexión con el servidor de EcoBali. Verifique su red.',
        type: ApiExceptionType.connection,
      );
    case DioExceptionType.badResponse:
      final data = error.response?.data;
      final detail = (data is Map && data['detail'] != null)
          ? data['detail'].toString()
          : 'El servidor respondió con un error.';
      return ApiException(detail, statusCode: error.response?.statusCode, type: ApiExceptionType.server);
    case DioExceptionType.cancel:
      return const ApiException('La solicitud fue cancelada.', type: ApiExceptionType.cancelled);
    default:
      return ApiException(error.message ?? 'Ocurrió un error inesperado.');
  }
}
