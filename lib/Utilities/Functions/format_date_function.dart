import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  // Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the date as 'Aug 30 2024' and the time as '12:30pm'
  String formattedDate = DateFormat('MMM dd yyyy').format(dateTime);
  String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();

  return '$formattedDate, $formattedTime';
}
