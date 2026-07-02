import 'package:flutter/material.dart';

/// A small metric card (icon + label + value), reused in Home's quick
/// stats row and in the full weather detail grid.
class MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MetricTile({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
