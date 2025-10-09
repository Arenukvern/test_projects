/// Utility functions for formatting dates and times for display.
library;

/// Formats a date as DD:MM:YYYY.
///
/// Example:
/// ```dart
/// final date = DateTime(2025, 10, 21);
/// final formatted = formatDate(date); // "21:10:2025"
/// ```
String formatDate(final DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}:${date.month.toString().padLeft(2, '0')}:${date.year}';

/// Formats a time as HH:MM.
///
/// Example:
/// ```dart
/// final time = DateTime(2025, 10, 21, 9, 30);
/// final formatted = formatTime(time); // "09:30"
/// ```
String formatTime(final DateTime time) =>
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

/// Formats a time range as HH:MM - HH:MM.
///
/// Returns empty string if either start or end is null.
///
/// Example:
/// ```dart
/// final start = DateTime(2025, 10, 21, 9, 0);
/// final end = DateTime(2025, 10, 21, 9, 45);
/// final formatted = formatTimeRange(start, end); // "09:00 - 09:45"
/// ```
String formatTimeRange(final DateTime? start, final DateTime? end) {
  if (start == null || end == null) return '';

  return '${formatTime(start)} - ${formatTime(end)}';
}

/// Formats a complete date and time range.
///
/// For single-day events, returns only the time range.
/// For multi-day events, includes both dates with times.
///
/// Returns empty string if either start or end is null.
///
/// Examples:
/// ```dart
/// // Single day
/// final start = DateTime(2025, 10, 21, 9, 0);
/// final end = DateTime(2025, 10, 21, 9, 45);
/// formatDateTimeRange(start, end); // Returns date: "21:10:2025", time: "09:00 - 09:45"
///
/// // Multi-day
/// final start = DateTime(2025, 10, 21, 9, 0);
/// final end = DateTime(2025, 10, 22, 10, 0);
/// formatDateTimeRange(start, end); // Returns date: "21:10:2025 - 22:10:2025", time: "09:00 - 10:00"
/// ```
({String date, String time}) formatDateTimeRange(
  final DateTime? start,
  final DateTime? end,
) {
  if (start == null || end == null) return (date: '', time: '');

  final isSameDay =
      start.year == end.year &&
      start.month == end.month &&
      start.day == end.day;

  final dateStr = isSameDay
      ? formatDate(start)
      : '${formatDate(start)} - ${formatDate(end)}';

  final timeStr = formatTimeRange(start, end);

  return (date: dateStr, time: timeStr);
}
