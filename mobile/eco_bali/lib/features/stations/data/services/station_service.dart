import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/station_model.dart';

/// Consumes `GET /api/v1/stations` from the EcoBali backend.
class StationService {
  final Dio _dio;

  const StationService(this._dio);

  Future<List<StationModel>> getStations() async {
    try {
      final response = await _dio.get<List<dynamic>>(ApiConstants.stations);
      return response.data!
          .map((item) => StationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

final stationServiceProvider = Provider<StationService>((ref) {
  return StationService(ref.watch(dioProvider));
});
