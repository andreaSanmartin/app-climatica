import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/coordinates.dart';
import '../../shared/models/selected_location.dart';
import '../services/location_service.dart';

/// Fallback used when GPS is unavailable or permission is denied, matching
/// the original prototype's default station (Guayaquil).
const defaultLocation = SelectedLocation(
  coordinates: Coordinates(latitude: -2.1811, longitude: -79.8860),
  label: 'Guayaquil (predeterminado)',
);

/// Holds the location used across Home, Clima, Alertas y Recomendaciones.
/// Starts by requesting the device GPS position, mirroring the prototype's
/// "Obtener mi Ubicación Exacta", and falls back to the default station.
/// Selecting a station elsewhere in the app updates this same provider so
/// every screen refreshes together.
class SelectedLocationNotifier extends AsyncNotifier<SelectedLocation> {
  @override
  Future<SelectedLocation> build() => _tryCurrentLocation();

  Future<SelectedLocation> _tryCurrentLocation() async {
    try {
      final coordinates = await ref.read(locationServiceProvider).getCurrentLocation();
      return SelectedLocation(coordinates: coordinates, label: 'Mi ubicación actual');
    } on LocationException {
      return defaultLocation;
    }
  }

  Future<void> useCurrentLocation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_tryCurrentLocation);
  }

  void selectStation({required Coordinates coordinates, required String label}) {
    state = AsyncData(SelectedLocation(coordinates: coordinates, label: label));
  }
}

final selectedLocationProvider =
    AsyncNotifierProvider<SelectedLocationNotifier, SelectedLocation>(SelectedLocationNotifier.new);
