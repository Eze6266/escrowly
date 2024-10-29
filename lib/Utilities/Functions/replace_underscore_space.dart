String replaceUnderscoresWithSpaces(String input) {
  return input
      .replaceAll('_', ' ') // Replace underscores with spaces
      .split(' ') // Split the string into a list of words
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : word) // Capitalize the first letter of each word
      .join(' '); // Join the words back into a string
}
