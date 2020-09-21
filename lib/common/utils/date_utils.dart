import 'package:intl/intl.dart';

class DateUtils {
  static String getFormatterDate(String seconds) {
    final timeInMilliseconds = int.parse(seconds) * 1000;
    final date = DateTime.fromMillisecondsSinceEpoch(timeInMilliseconds);
    return DateFormat.yMMMd().format(date);
  }
}
