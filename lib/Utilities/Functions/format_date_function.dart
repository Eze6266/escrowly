import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  // Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the date as 'Aug 30 2024' and the time as '12:30pm'
  String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
  String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();

  return '$formattedDate, $formattedTime';
}

String formatTime(String time) {
  try {
    DateTime parsedTime = DateTime.parse(time);
    // Format time to 12-hour format with am/pm
    return DateFormat('hh:mma').format(parsedTime).toLowerCase();
  } catch (e) {
    return "Invalid time format";
  }
}
