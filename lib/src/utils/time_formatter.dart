import 'package:intl/intl.dart';

class DateFormatter {
  String formatDateString(String dateString, bool isTime) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm').format(dateTime);
    return isTime ? formattedTime : formattedDate;
  }

  String convertToIsoFormat({required String date, required String time}) {
    try {
      if (date.isEmpty) {
        throw const FormatException("Date string is empty");
      }
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date.split(' ')[0]);
      if (time.isEmpty) {
        throw const FormatException("Time string is empty");
      }
      DateTime parsedTime = DateFormat('h:mm a').parse(time);
      DateTime combinedDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute,
        10,
        922,
      );
      String formattedDateTime = combinedDateTime.toUtc().toIso8601String();
      return formattedDateTime;
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
