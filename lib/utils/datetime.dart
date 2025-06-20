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


String incrementHour(String timeString) {
  final time = DateTime.parse("2023-01-01 ${_convertTo24Hour(timeString)}");
  final updatedTime = time.add(Duration(hours: 1));
  return _formatTo12Hour(updatedTime);
}

String _convertTo24Hour(String time) {
  final format = RegExp(r'(\d+):(\d+) (AM|PM)');
  final match = format.firstMatch(time);

  if (match == null) return time;

  int hour = int.parse(match.group(1)!);
  int minute = int.parse(match.group(2)!);
  String meridian = match.group(3)!;

  if (meridian == 'PM' && hour != 12) hour += 12;
  if (meridian == 'AM' && hour == 12) hour = 0;

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

String _formatTo12Hour(DateTime time) {
  final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
  final meridian = time.hour >= 12 ? 'PM' : 'AM';
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute $meridian';
}