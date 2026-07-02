import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/components/level_badge.dart';
import '../../../../shared/components/status_card.dart';
import '../../../../shared/widgets/async_value_widget.dart';
import '../../data/models/alert_model.dart';
import '../providers/alerts_providers.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Alertas climáticas')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(alertsProvider.future),
        child: AsyncValueWidget<AlertsResult>(
          value: alertsAsync,
          onRetry: () => ref.invalidate(alertsProvider),
          data: (result) {
            if (result.alerts.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  StatusCard(
                    title: 'Sin alertas activas',
                    message: 'No se registran anomalías climáticas en esta ubicación.',
                    isPositive: true,
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: result.alerts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _AlertCard(alert: result.alerts[index]),
            );
          },
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final AlertModel alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    alert.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                LevelBadge(level: alert.level),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              alert.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
