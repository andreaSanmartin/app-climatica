import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/components/app_list_tile.dart';
import '../../../../shared/components/level_badge.dart';
import '../../../../shared/components/metric_tile.dart';
import '../../../../shared/components/section_header.dart';
import '../../../../shared/components/status_card.dart';
import '../../../../shared/widgets/async_value_widget.dart';
import '../../../alerts/data/models/alert_model.dart';
import '../../../alerts/presentation/providers/alerts_providers.dart';
import '../../../weather/data/models/weather_model.dart';
import '../../../weather/presentation/providers/weather_providers.dart';
import '../../../weather/presentation/utils/weather_presentation.dart';

/// Home shell: current location, a compact weather summary and a preview
/// of active alerts. Full detail lives on their own screens.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(selectedLocationProvider);
    final weatherAsync = ref.watch(currentWeatherProvider);
    final alertsAsync = ref.watch(alertsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('EcoBali')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentWeatherProvider);
          ref.invalidate(alertsProvider);
          await ref.read(currentWeatherProvider.future);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppListTile(
              leadingIcon: Icons.my_location_outlined,
              title: locationAsync.value?.label ?? 'Ubicación',
              subtitle: locationAsync.value != null
                  ? formatCoordinates(
                      locationAsync.value!.coordinates.latitude,
                      locationAsync.value!.coordinates.longitude,
                    )
                  : 'Obteniendo ubicación…',
              onTap: () => context.push(AppRoutes.weather),
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: 'Clima actual',
              actionLabel: 'Ver más',
              onAction: () => context.push(AppRoutes.weather),
            ),
            const SizedBox(height: 10),
            AsyncValueWidget<WeatherModel>(
              value: weatherAsync,
              onRetry: () => ref.invalidate(currentWeatherProvider),
              data: (weather) => _WeatherSummary(weather: weather),
            ),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Alertas activas',
              actionLabel: 'Ver todas',
              onAction: () => context.go(AppRoutes.alerts),
            ),
            const SizedBox(height: 10),
            AsyncValueWidget<AlertsResult>(
              value: alertsAsync,
              onRetry: () => ref.invalidate(alertsProvider),
              data: (result) => _AlertsPreview(alerts: result.alerts),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherSummary extends StatelessWidget {
  final WeatherModel weather;

  const _WeatherSummary({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(weatherConditionIcon(weather), size: 44, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.temperature != null ? '${weather.temperature!.round()}°C' : '—',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(weatherConditionLabel(weather)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MetricTile(
                icon: Icons.water_drop_outlined,
                label: 'Humedad',
                value: weather.humidity != null ? '${weather.humidity!.round()}%' : '—',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MetricTile(
                icon: Icons.wb_sunny_outlined,
                label: 'Índice UV',
                value: weather.uvIndex?.toStringAsFixed(1) ?? '—',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AlertsPreview extends StatelessWidget {
  final List<AlertModel> alerts;

  const _AlertsPreview({required this.alerts});

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return const StatusCard(
        title: 'Sin alertas activas',
        message: 'No se registran anomalías climáticas en esta ubicación.',
        isPositive: true,
      );
    }
    return Column(
      children: alerts
          .take(2)
          .map(
            (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  title: Text(alert.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: LevelBadge(level: alert.level),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
