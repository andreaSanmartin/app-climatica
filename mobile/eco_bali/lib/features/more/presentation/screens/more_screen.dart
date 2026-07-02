import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/components/app_list_tile.dart';

/// Overflow menu for screens not yet promoted to the bottom navigation bar.
/// Auth, notifications, favorites and profile will be added here in a
/// future phase, without needing to touch the rest of the app.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Más')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AppListTile(
          leadingIcon: Icons.eco_outlined,
          title: 'Recomendaciones',
          subtitle: 'Sugerencias agrícolas y ambientales',
          onTap: () => context.push(AppRoutes.recommendations),
        ),
      ),
    );
  }
}
