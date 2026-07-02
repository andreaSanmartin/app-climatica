import 'package:flutter/material.dart';

/// Brand and semantic colors shared across the app. Kept deliberately
/// restrained (a single accent + neutrals) for a serious, institutional look.
class AppColors {
  AppColors._();

  static const Color seed = Color(0xFF14532D); // EcoBali forest green
  static const Color success = Color(0xFF16A34A);
  static const Color info = Color(0xFF0B5FA5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color critical = Color(0xFFDC2626);
}
