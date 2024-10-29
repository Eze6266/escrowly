String formatNumberToreadable(dynamic number) {
  // Convert the input to a double if it's not already
  double num;

  if (number is String) {
    num = double.tryParse(number) ?? 0;
  } else if (number is int || number is double) {
    num = number.toDouble();
  } else {
    throw ArgumentError('Invalid number format');
  }

  // Format the number based on its size
  if (num >= 1000000) {
    return (num / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') +
        'M';
  } else if (num >= 1000) {
    return (num / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') +
        'k';
  } else {
    return num.toString();
  }
}
