import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/selected_location_provider.dart';
import '../../data/models/recommendation_model.dart';
import '../../data/services/recommendation_service.dart';

/// Current recommendations for the shared selected location.
final recommendationsProvider = FutureProvider.autoDispose<RecommendationsResult>((ref) async {
  final location = await ref.watch(selectedLocationProvider.future);
  return ref.watch(recommendationServiceProvider).getRecommendations(location.coordinates);
});
