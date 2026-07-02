import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/coordinates.dart';
import '../models/alert_model.dart';

/// Consumes `GET /api/v1/alerts` from the EcoBali backend.
class AlertService {
  final Dio _dio;

  const AlertService(this._dio);

  Future<AlertsResult> getAlerts(Coordinates coordinates) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.alerts,
        queryParameters: {
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
      );
      return AlertsResult.fromJson(response.data!);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

final alertServiceProvider = Provider<AlertService>((ref) {
  return AlertService(ref.watch(dioProvider));
});
