class Helpers {
  static String formatTime(DateTime dateTime) {
    final int hour = dateTime.hour;
    final String period = hour < 12 ? 'AM' : 'PM';
    final int formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$formattedHour:$minute $period';
  }
}
