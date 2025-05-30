import 'package:intl/intl.dart';

String convertToPostgresTimestamp(String timeStr) {
  try {
    final cleaned = timeStr.trim();
    final inputFormat = DateFormat('h:mm a');
    final time = inputFormat.parse(cleaned);
    final formatted = DateFormat('HH:mm:ss').format(time);
    return '1970-01-01 $formatted';
  } catch (e) {
    print('🛑 Failed to convert time string "$timeStr": $e');
    return '1970-01-01 00:00:00';
  }
}
