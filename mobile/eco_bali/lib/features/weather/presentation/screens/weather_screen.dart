import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/components/metric_tile.dart';
import '../../../../shared/widgets/async_value_widget.dart';
import '../../data/models/weather_model.dart';
import '../providers/weather_providers.dart';
import '../utils/weather_presentation.dart';

/// Full detail view for the currently selected location. Only shows fields
/// the backend actually returns — no hourly/5-day forecast, since
/// Open-Meteo's "current" endpoint doesn't provide one.
class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    final locationAsync = ref.watch(selectedLocationProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Clima actual')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(currentWeatherProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              locationAsync.value?.label ?? 'Ubicación',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 2),
            Text(
              formatLongDate(DateTime.now()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            AsyncValueWidget<WeatherModel>(
              value: weatherAsync,
              onRetry: () => ref.invalidate(currentWeatherProvider),
              data: (weather) => _WeatherDetail(weather: weather),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final WeatherModel weather;

  const _WeatherDetail({required this.weather});

  static String _fmt(double? value, String unit) => value != null ? '${value.round()}$unit' : '—';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(weatherConditionIcon(weather), size: 48, color: colorScheme.primary),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.temperature != null ? '${weather.temperature!.round()}°C' : '—',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(weatherConditionLabel(weather), style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.6,
          children: [
            MetricTile(icon: Icons.water_drop_outlined, label: 'Humedad', value: _fmt(weather.humidity, '%')),
            MetricTile(icon: Icons.air_outlined, label: 'Viento', value: _fmt(weather.windSpeed, ' km/h')),
            MetricTile(
              icon: Icons.explore_outlined,
              label: 'Dirección viento',
              value: _fmt(weather.windDirection, '°'),
            ),
            MetricTile(icon: Icons.speed_outlined, label: 'Presión', value: _fmt(weather.pressure, ' hPa')),
            MetricTile(
              icon: Icons.grain_outlined,
              label: 'Precipitación',
              value: _fmt(weather.precipitation, ' mm'),
            ),
            MetricTile(
              icon: Icons.wb_sunny_outlined,
              label: 'Índice UV',
              value: weather.uvIndex?.toStringAsFixed(1) ?? '—',
            ),
            MetricTile(
              icon: Icons.grass_outlined,
              label: 'Humedad suelo',
              value: weather.soilMoisture != null ? weather.soilMoisture!.toStringAsFixed(2) : '—',
            ),
            MetricTile(
              icon: Icons.eco_outlined,
              label: 'Evapotranspiración',
              value: weather.evapotranspiration != null
                  ? '${weather.evapotranspiration!.toStringAsFixed(1)} mm'
                  : '—',
            ),
          ],
        ),
      ],
    );
  }
}
