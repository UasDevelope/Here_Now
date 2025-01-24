import 'package:intl/intl.dart';

class DateTimeUtils {
  // Formats a DateTime to 'YYYY-MM-DD' format
  static String formatToIso(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // Formats a DateTime to 'DD-MM-YYYY' format
  static String formatToDmy(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  // Formats a DateTime to 'MM-DD-YYYY' format
  static String formatToMdy(DateTime dateTime) {
    return DateFormat('MM-dd-yyyy').format(dateTime);
  }

  // Formats a DateTime to include time: 'YYYY-MM-DD HH:mm:ss AM/PM'
  static String formatToIsoWithTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }


  // Formats to a readable string like 'January 23, 2025'
  static String formatToReadable(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  // Converts a string to DateTime using a given format
  static DateTime parseFromString(String dateString, String format) {
    return DateFormat(format).parse(dateString);
  }

  // Get current DateTime in ISO format
  static String getCurrentIso() {
    return formatToIso(DateTime.now());
  }

  // Get current DateTime in ISO with time
  static String getCurrentIsoWithTime() {
    return formatToIsoWithTime(DateTime.now());
  }

  // Calculate the difference between two DateTimes in days
  static int calculateDifferenceInDays(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  // Get the time from a DateTime: 'HH:mm:ss'
  static String getTimeOnly(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  // Formats a DateTime to 'Day, Month Date, Year': 'Thursday, January 23, 2025'
  static String formatToDayMonthYear(DateTime dateTime) {
    return DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
  }
}
