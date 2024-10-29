import 'package:intl/intl.dart';

String formatNumberWithCommas(dynamic number) {
  // If the input is a String, try to parse it to a double
  if (number is String) {
    number = double.tryParse(number) ?? 0;
  }

  // Format the number with commas
  final NumberFormat numberFormat =
      NumberFormat('#,##0.00'); // Adjust format for decimals
  return numberFormat.format(number);
}
