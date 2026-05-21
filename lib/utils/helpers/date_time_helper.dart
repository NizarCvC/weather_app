import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime _convertFromUtcToLocal(int utcTime) {
    return DateTime.fromMillisecondsSinceEpoch(
      utcTime * 1000,
      isUtc: true,
    ).toLocal();
  }

  static String getTime(int utcTime) {
    DateTime date = _convertFromUtcToLocal(utcTime);
    String formattedTime = DateFormat('HH:00').format(date);
    return formattedTime;
  }

  static String getShortDayName(int utcTime) {
    DateTime date = _convertFromUtcToLocal(utcTime);
    return DateFormat('EEE').format(date);
  }

  static String getDayName(int utcTime) {
    DateTime date = _convertFromUtcToLocal(utcTime);
    return DateFormat('EEEE').format(date);
  }

  static String getDayAndMonth(int utcTime) {
    DateTime date = _convertFromUtcToLocal(utcTime);
    return DateFormat('d MMMM').format(date);
  }
}
