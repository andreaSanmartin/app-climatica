import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../shared/components/app_list_tile.dart';
import '../../../../shared/models/coordinates.dart';
import '../../../../shared/widgets/async_value_widget.dart';
import '../../data/models/station_model.dart';
import '../providers/stations_providers.dart';

/// Lists the backend's reference stations, with client-side search and a
/// "Cercanas" filter that sorts by real distance to the shared location.
class StationsScreen extends ConsumerWidget {
  const StationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsAsync = ref.watch(filteredStationsProvider);
    final filter = ref.watch(stationFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Estaciones meteorológicas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar estación',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => ref.read(stationSearchQueryProvider.notifier).state = value,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Todas'),
                  selected: filter == StationFilter.all,
                  onSelected: (_) => ref.read(stationFilterProvider.notifier).state = StationFilter.all,
                ),
                ChoiceChip(
                  label: const Text('Cercanas'),
                  selected: filter == StationFilter.nearby,
                  onSelected: (_) => ref.read(stationFilterProvider.notifier).state = StationFilter.nearby,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: AsyncValueWidget<List<StationModel>>(
                value: stationsAsync,
                onRetry: () => ref.invalidate(stationsProvider),
                data: (stations) {
                  if (stations.isEmpty) {
                    return const Center(child: Text('No se encontraron estaciones.'));
                  }
                  return ListView.separated(
                    itemCount: stations.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final station = stations[index];
                      return AppListTile(
                        leadingIcon: Icons.location_on_outlined,
                        title: station.name,
                        subtitle: station.region,
                        onTap: () {
                          ref.read(selectedLocationProvider.notifier).selectStation(
                                coordinates: Coordinates(latitude: station.latitude, longitude: station.longitude),
                                label: '${station.name}, ${station.region}',
                              );
                          context.push(AppRoutes.weather);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
