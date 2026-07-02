/// Formats a coordinate pair as `lat°, lon°`, matching the precision used
/// by the original prototype (4 decimal places).
String formatCoordinates(double latitude, double longitude) {
  return '${latitude.toStringAsFixed(4)}°, ${longitude.toStringAsFixed(4)}°';
}
