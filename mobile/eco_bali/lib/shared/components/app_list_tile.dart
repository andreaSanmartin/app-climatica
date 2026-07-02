import 'package:flutter/material.dart';

/// Generic tappable row (leading icon, title, subtitle, trailing widget),
/// reused for the location row, station rows and the "Más" menu.
class AppListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const AppListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(leadingIcon, color: colorScheme.onPrimaryContainer, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
      ),
    );
  }
}
