import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Colored pill for an alert's severity level ("info", "warning", "critical"
/// as returned by the backend).
class LevelBadge extends StatelessWidget {
  final String level;

  const LevelBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (level) {
      'critical' => (AppColors.critical, 'Crítica'),
      'warning' => (AppColors.warning, 'Advertencia'),
      _ => (AppColors.info, 'Informativa'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}
