import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eco_bali/core/providers/selected_location_provider.dart';
import 'package:eco_bali/features/alerts/data/models/alert_model.dart';
import 'package:eco_bali/features/alerts/presentation/providers/alerts_providers.dart';
import 'package:eco_bali/features/weather/data/models/weather_model.dart';
import 'package:eco_bali/features/weather/presentation/providers/weather_providers.dart';
import 'package:eco_bali/main.dart';
import 'package:eco_bali/shared/models/coordinates.dart';
import 'package:eco_bali/shared/models/selected_location.dart';

/// Resolves instantly to a fixed location, avoiding real GPS/platform calls.
class _FakeLocationNotifier extends SelectedLocationNotifier {
  @override
  Future<SelectedLocation> build() async => const SelectedLocation(
        coordinates: Coordinates(latitude: -2.1811, longitude: -79.8860),
        label: 'Guayaquil, Guayas',
      );
}

void main() {
  testWidgets('App shows splash branding then navigates to Home', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Avoid real GPS/network calls during the widget test.
          selectedLocationProvider.overrideWith(_FakeLocationNotifier.new),
          currentWeatherProvider.overrideWith(
            (ref) async => const WeatherModel(
              latitude: -2.1811,
              longitude: -79.8860,
              temperature: 28,
              humidity: 70,
              uvIndex: 5,
            ),
          ),
          alertsProvider.overrideWith(
            (ref) async => const AlertsResult(latitude: -2.1811, longitude: -79.8860, alerts: []),
          ),
        ],
        child: const EcoBaliApp(),
      ),
    );

    expect(find.text('EcoBali'), findsOneWidget);

    // Let the splash screen's navigation timer fire and the app settle on Home.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Clima actual'), findsOneWidget);
    expect(find.text('Sin alertas activas'), findsOneWidget);
  });
}
