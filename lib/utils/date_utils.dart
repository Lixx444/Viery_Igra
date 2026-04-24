import 'package:intl/intl.dart';

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year && date.month == now.month && date.day == now.day;
}

String formatDateShort(DateTime date) {
  return DateFormat.MMMd().format(date);
}

String formatDateFull(DateTime date) {
  return DateFormat.yMMMMEEEEd().format(date);
}

String formatTime(DateTime date) {
  return DateFormat.Hm().format(date);
}

String formatDateTime(DateTime date) {
  return DateFormat.yMd().add_Hm().format(date);
}
