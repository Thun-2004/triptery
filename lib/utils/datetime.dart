import 'package:intl/intl.dart';

String formatDateWithOrdinal(DateTime date) {
  final String daySuffix = _getDaySuffix(date.day);
  final String formatted = DateFormat('EEEE, d').format(date) +
      daySuffix +
      DateFormat(' MMMM yyyy').format(date);
  return formatted;
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}