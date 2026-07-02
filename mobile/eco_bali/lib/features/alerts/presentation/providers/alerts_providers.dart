import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../data/models/alert_model.dart';
import '../../data/services/alert_service.dart';

/// Current alerts for the shared selected location.
final alertsProvider = FutureProvider.autoDispose<AlertsResult>((ref) async {
  final location = await ref.watch(selectedLocationProvider.future);
  return ref.watch(alertServiceProvider).getAlerts(location.coordinates);
});
