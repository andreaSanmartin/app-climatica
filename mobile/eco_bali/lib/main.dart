import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: EcoBaliApp()));
}

class EcoBaliApp extends StatelessWidget {
  const EcoBaliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EcoBali',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
