import 'package:flutter/material.dart';

import '../../data/models/weather_model.dart';

/// Derives a short, honest condition label from the numeric fields the
/// backend actually returns (it has no "cloud cover"/condition field, so
/// nothing here is invented — it's read directly off real measurements).
String weatherConditionLabel(WeatherModel weather) {
  if ((weather.precipitation ?? 0) > 1) return 'Lluvia';
  if ((weather.uvIndex ?? 0) >= 8) return 'Radiación solar alta';
  if ((weather.windSpeed ?? 0) > 40) return 'Viento fuerte';
  return 'Condiciones estables';
}

IconData weatherConditionIcon(WeatherModel weather) {
  if ((weather.precipitation ?? 0) > 1) return Icons.water_drop_outlined;
  if ((weather.uvIndex ?? 0) >= 8) return Icons.wb_sunny_outlined;
  if ((weather.windSpeed ?? 0) > 40) return Icons.air_outlined;
  return Icons.cloud_outlined;
}
