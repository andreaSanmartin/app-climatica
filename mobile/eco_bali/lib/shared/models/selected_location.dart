import 'coordinates.dart';

/// The place currently used to query weather, alerts and recommendations,
/// paired with a human-friendly label for display.
class SelectedLocation {
  final Coordinates coordinates;
  final String label;

  const SelectedLocation({required this.coordinates, required this.label});
}
