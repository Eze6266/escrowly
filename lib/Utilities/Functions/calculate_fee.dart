String calculateTransactionFee(String amount) {
  try {
    // Convert the string to a double
    double parsedAmount = double.parse(amount);

    // Calculate 2.5% of the amount
    double fee = parsedAmount * 0.02;

    // Format the fee as a string with 2 decimal places
    return fee.toStringAsFixed(2);
  } catch (e) {
    // Handle cases where the input is not a valid number
    throw ArgumentError("Invalid input: Please provide a valid number.");
  }
}

String splitAmount(String amount) {
  try {
    // Convert the string to a double
    double parsedAmount = double.parse(amount);

    // Calculate half of the amount
    double half = parsedAmount / 2;

    // Format the half amount as a string with 2 decimal places
    return half.toStringAsFixed(2);
  } catch (e) {
    // Handle cases where the input is not a valid number
    throw ArgumentError("Invalid input: Please provide a valid number.");
  }
}
