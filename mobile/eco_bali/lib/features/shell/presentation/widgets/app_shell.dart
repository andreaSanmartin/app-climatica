import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Persistent bottom navigation shell hosting Inicio, Estaciones, Alertas
/// and Más, each with its own independent navigation stack.
class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on),
            label: 'Estaciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning_amber_outlined),
            selectedIcon: Icon(Icons.warning_amber),
            label: 'Alertas',
          ),
          NavigationDestination(icon: Icon(Icons.more_horiz_outlined), selectedIcon: Icon(Icons.more_horiz), label: 'Más'),
        ],
      ),
    );
  }
}
