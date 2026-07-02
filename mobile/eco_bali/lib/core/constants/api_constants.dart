import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Centralized backend configuration. This is the single place that knows
/// where the EcoBali FastAPI backend lives and how its routes are shaped.
class ApiConstants {
  ApiConstants._();

  /// Base URL of the backend.
  ///
  /// - Android emulator cannot reach the host machine via `localhost`, so it
  ///   uses the special alias `10.0.2.2`.
  /// - iOS simulator, web and desktop targets share the host network, so
  ///   `localhost` works.
  ///
  /// For a physical device on the same Wi-Fi as the backend, replace this
  /// with the machine's LAN IP (e.g. `http://192.168.1.10:8000`).
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:8000';
    if (Platform.isAndroid) return 'http://10.0.2.2:8000';
    return 'http://localhost:8000';
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  static const String _v1 = '/api/v1';

  static const String health = '/';
  static const String weatherCurrent = '$_v1/weather/current';
  static const String stations = '$_v1/stations';
  static const String alerts = '$_v1/alerts';
  static const String recommendations = '$_v1/recommendations';
}
