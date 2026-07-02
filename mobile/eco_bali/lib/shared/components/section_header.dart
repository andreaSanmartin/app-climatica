import 'package:flutter/material.dart';

/// A title with an optional trailing action ("Ver todas"/"Ver más"), used
/// to introduce list sections across Home and the detail screens.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (actionLabel != null) TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}
