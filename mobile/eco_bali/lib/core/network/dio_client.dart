import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';

/// Builds the single [Dio] instance used to talk to the EcoBali backend.
class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }
}

/// Shared [Dio] instance, injected into every service via Riverpod.
final dioProvider = Provider<Dio>((ref) => DioClient.create());
