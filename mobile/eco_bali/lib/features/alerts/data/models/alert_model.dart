/// A single alert entry, as returned inside `GET /api/v1/alerts`.
class AlertModel {
  final String level; // "info", "warning" o "critical"
  final String title;
  final String message;

  const AlertModel({required this.level, required this.title, required this.message});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      level: json['level'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
    );
  }
}

/// Maps the full response of `GET /api/v1/alerts`.
class AlertsResult {
  final double latitude;
  final double longitude;
  final List<AlertModel> alerts;

  const AlertsResult({
    required this.latitude,
    required this.longitude,
    required this.alerts,
  });

  factory AlertsResult.fromJson(Map<String, dynamic> json) {
    return AlertsResult(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      alerts: (json['alerts'] as List<dynamic>)
          .map((item) => AlertModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
