import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../data/models/weather_model.dart';
import '../../data/services/weather_service.dart';

/// Current weather for the shared selected location (`selectedLocationProvider`).
final currentWeatherProvider = FutureProvider.autoDispose<WeatherModel>((ref) async {
  final location = await ref.watch(selectedLocationProvider.future);
  return ref.watch(weatherServiceProvider).getCurrentWeather(location.coordinates);
});
