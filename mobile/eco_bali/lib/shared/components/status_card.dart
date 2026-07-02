import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// A composed card showing a titled status with a colored indicator dot.
/// Used for empty/positive states (e.g. "sin alertas activas").
class StatusCard extends StatelessWidget {
  final String title;
  final String message;
  final bool isPositive;

  const StatusCard({
    super.key,
    required this.title,
    required this.message,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indicatorColor = isPositive ? AppColors.success : colorScheme.error;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(color: indicatorColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
