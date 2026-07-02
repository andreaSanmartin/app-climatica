/// Route path constants, kept separate from [AppRouter] so screens can
/// reference a path without importing the router (and its screen imports).
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String stations = '/stations';
  static const String alerts = '/alerts';
  static const String more = '/more';
  static const String weather = '/weather';
  static const String recommendations = '/recommendations';
}
