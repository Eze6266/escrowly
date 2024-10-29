bool isValidEmail(String email) {
  // Define a regular expression for email validation
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Check if the provided email matches the regex pattern
  return emailRegex.hasMatch(email);
}
