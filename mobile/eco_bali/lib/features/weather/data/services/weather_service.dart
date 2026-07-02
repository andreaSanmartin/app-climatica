import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/coordinates.dart';
import '../models/weather_model.dart';

/// Consumes `GET /api/v1/weather/current` from the EcoBali backend.
class WeatherService {
  final Dio _dio;

  const WeatherService(this._dio);

  Future<WeatherModel> getCurrentWeather(Coordinates coordinates) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.weatherCurrent,
        queryParameters: {
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
      );
      return WeatherModel.fromJson(response.data!);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(ref.watch(dioProvider));
});
