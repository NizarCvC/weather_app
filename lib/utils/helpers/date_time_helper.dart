import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getTime(int utcTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000);
    String formattedTime = DateFormat('HH:MM').format(date);
    return formattedTime;
  }

  static String getDayName(int utcTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000);
    return DateFormat('EEE').format(date);
  }
}
