/// Maps the JSON returned by `GET /api/v1/weather/current`.
class WeatherModel {
  final double latitude;
  final double longitude;
  final double? temperature;
  final double? humidity;
  final double? windSpeed;
  final double? windDirection;
  final double? pressure;
  final double? precipitation;
  final double? uvIndex;
  final double? soilMoisture;
  final double? evapotranspiration;
  final String? timezone;

  const WeatherModel({
    required this.latitude,
    required this.longitude,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.windDirection,
    this.pressure,
    this.precipitation,
    this.uvIndex,
    this.soilMoisture,
    this.evapotranspiration,
    this.timezone,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    double? asDouble(dynamic value) => (value as num?)?.toDouble();

    return WeatherModel(
      latitude: asDouble(json['latitude'])!,
      longitude: asDouble(json['longitude'])!,
      temperature: asDouble(json['temperature']),
      humidity: asDouble(json['humidity']),
      windSpeed: asDouble(json['wind_speed']),
      windDirection: asDouble(json['wind_direction']),
      pressure: asDouble(json['pressure']),
      precipitation: asDouble(json['precipitation']),
      uvIndex: asDouble(json['uv_index']),
      soilMoisture: asDouble(json['soil_moisture']),
      evapotranspiration: asDouble(json['evapotranspiration']),
      timezone: json['timezone'] as String?,
    );
  }
}
