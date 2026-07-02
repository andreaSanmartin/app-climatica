const _weekdays = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
const _months = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

/// Formats a date as "Martes, 1 de julio de 2026" without pulling in intl.
String formatLongDate(DateTime date) {
  final weekday = _weekdays[date.weekday - 1];
  final month = _months[date.month - 1];
  final capitalized = '${weekday[0].toUpperCase()}${weekday.substring(1)}';
  return '$capitalized, ${date.day} de $month de ${date.year}';
}
