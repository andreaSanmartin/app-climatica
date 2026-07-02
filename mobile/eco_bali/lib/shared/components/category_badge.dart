import 'package:flutter/material.dart';

/// Icon-in-circle used to visually categorize a recommendation
/// ("agriculture", "health" or "environment", as returned by the backend).
class CategoryBadge extends StatelessWidget {
  final String category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (category) {
      'agriculture' => (Icons.agriculture_outlined, const Color(0xFF16A34A)),
      'health' => (Icons.health_and_safety_outlined, const Color(0xFFF59E0B)),
      _ => (Icons.public_outlined, const Color(0xFF0B5FA5)),
    };

    return CircleAvatar(
      radius: 20,
      backgroundColor: color.withValues(alpha: 0.12),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
