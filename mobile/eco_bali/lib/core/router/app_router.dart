import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/recommendations/presentation/screens/recommendations_screen.dart';
import '../../features/shell/presentation/widgets/app_shell.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/stations/presentation/screens/stations_screen.dart';
import '../../features/weather/presentation/screens/weather_screen.dart';
import 'app_routes.dart';

/// Centralized navigation graph. Inicio, Estaciones, Alertas and Más share
/// the bottom navigation shell; Clima actual and Recomendaciones are pushed
/// full-screen on top of it (matching the approved mockup's back-arrow
/// detail screens).
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.weather,
        name: 'weather',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const WeatherScreen(),
      ),
      GoRoute(
        path: AppRoutes.recommendations,
        name: 'recommendations',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RecommendationsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.home, name: 'home', builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: AppRoutes.stations, name: 'stations', builder: (context, state) => const StationsScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.alerts, name: 'alerts', builder: (context, state) => const AlertsScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.more, name: 'more', builder: (context, state) => const MoreScreen())],
          ),
        ],
      ),
    ],
  );
}
