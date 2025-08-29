
import 'package:intl/intl.dart';

class DateFormatter {
  static String getTimeAgo(DateTime dateTime ,{bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(dateTime);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1w' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}d';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1d' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1h' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1m' : 'A min ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s';
    } else {
      return 'Just now';
    }
  }
  static String getTimeDifference(String dateTime ,{bool numericDates = true}) {
    final currentTime = DateTime.now();
    DateFormat format = DateFormat("yyyy MM dd HH:mm:ss");
    DateTime ct = format.parse(currentTime.toString().split('.').first.replaceAll("-", " "));
    DateTime et = format.parse(dateTime.toString());
    final difference = et.difference(ct);

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    print("Difference: $hours:$minutes:$seconds");
    return "$hours:$minutes:$seconds";


  }

  static String getFormattedDateTime(String input){
    DateTime dateTime = DateTime.parse(input);
    String formatted = DateFormat('d MMM y hh:mm a').format(dateTime);
    return formatted;
  }
}