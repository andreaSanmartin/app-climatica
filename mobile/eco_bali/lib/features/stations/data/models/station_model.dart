/// Maps a single entry of `GET /api/v1/stations`.
class StationModel {
  final String name;
  final String region;
  final double latitude;
  final double longitude;
  final String description;

  const StationModel({
    required this.name,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      name: json['name'] as String,
      region: json['region'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String,
    );
  }
}
