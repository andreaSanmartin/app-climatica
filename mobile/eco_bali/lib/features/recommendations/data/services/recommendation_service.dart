import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/models/coordinates.dart';
import '../models/recommendation_model.dart';

/// Consumes `GET /api/v1/recommendations` from the EcoBali backend.
class RecommendationService {
  final Dio _dio;

  const RecommendationService(this._dio);

  Future<RecommendationsResult> getRecommendations(Coordinates coordinates) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.recommendations,
        queryParameters: {
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
      );
      return RecommendationsResult.fromJson(response.data!);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService(ref.watch(dioProvider));
});
