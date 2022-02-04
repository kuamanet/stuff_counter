extension DateTimeExtension on DateTime {
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
}
