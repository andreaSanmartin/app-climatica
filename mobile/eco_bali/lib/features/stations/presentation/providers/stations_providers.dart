import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../data/models/station_model.dart';
import '../../data/services/station_service.dart';

enum StationFilter { all, nearby }

final stationsProvider = FutureProvider.autoDispose<List<StationModel>>((ref) {
  return ref.watch(stationServiceProvider).getStations();
});

final stationFilterProvider = StateProvider.autoDispose<StationFilter>((ref) => StationFilter.all);
final stationSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

/// Combines the raw station list with the current search query, filter and
/// (for "Cercanas") the shared location, so the screen only has to render.
final filteredStationsProvider = Provider.autoDispose<AsyncValue<List<StationModel>>>((ref) {
  final stationsAsync = ref.watch(stationsProvider);
  final query = ref.watch(stationSearchQueryProvider).trim().toLowerCase();
  final filter = ref.watch(stationFilterProvider);
  final locationAsync = ref.watch(selectedLocationProvider);

  return stationsAsync.whenData((stations) {
    final filtered = query.isEmpty
        ? stations
        : stations
            .where((s) => s.name.toLowerCase().contains(query) || s.region.toLowerCase().contains(query))
            .toList();

    if (filter != StationFilter.nearby) return filtered;

    final origin = locationAsync.value?.coordinates;
    if (origin == null) return filtered;

    final sorted = [...filtered]
      ..sort((a, b) {
        final distanceA = Geolocator.distanceBetween(origin.latitude, origin.longitude, a.latitude, a.longitude);
        final distanceB = Geolocator.distanceBetween(origin.latitude, origin.longitude, b.latitude, b.longitude);
        return distanceA.compareTo(distanceB);
      });
    return sorted;
  });
});
