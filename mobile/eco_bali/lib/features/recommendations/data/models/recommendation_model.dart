/// A single recommendation entry, as returned inside `GET /api/v1/recommendations`.
class RecommendationModel {
  final String category; // "agriculture", "health" o "environment"
  final String message;

  const RecommendationModel({required this.category, required this.message});

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      category: json['category'] as String,
      message: json['message'] as String,
    );
  }
}

/// Maps the full response of `GET /api/v1/recommendations`.
class RecommendationsResult {
  final double latitude;
  final double longitude;
  final List<RecommendationModel> recommendations;

  const RecommendationsResult({
    required this.latitude,
    required this.longitude,
    required this.recommendations,
  });

  factory RecommendationsResult.fromJson(Map<String, dynamic> json) {
    return RecommendationsResult(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((item) => RecommendationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
