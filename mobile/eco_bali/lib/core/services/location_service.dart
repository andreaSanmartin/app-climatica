import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../shared/models/coordinates.dart';

/// Thrown when the device location cannot be obtained (service disabled or
/// permission not granted).
class LocationException implements Exception {
  final String message;

  const LocationException(this.message);

  @override
  String toString() => message;
}

/// Wraps `geolocator` to obtain the device's current GPS position, mirroring
/// the "Obtener mi Ubicación Exacta" behaviour of the original prototype.
class LocationService {
  const LocationService();

  Future<Coordinates> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException('El servicio de ubicación está desactivado.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException('Permiso de ubicación denegado.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException('Permiso de ubicación denegado permanentemente.');
    }

    final position = await Geolocator.getCurrentPosition();
    return Coordinates(latitude: position.latitude, longitude: position.longitude);
  }
}

final locationServiceProvider = Provider<LocationService>((ref) => const LocationService());
