import 'dart:math';

import 'package:flutter/material.dart';

String getFirstTwoLetters(String input) {
  // Trim and split the string into words
  List<String> words = input.trim().split(' ');

  if (words.length == 1) {
    // If there's only one word, return the first two letters capitalized
    return words[0].substring(0, 2).toUpperCase();
  } else if (words.length > 1) {
    // If there are two or more words, take the first letter of each word and capitalize them
    String firstLetter = words[0].substring(0, 1).toUpperCase();
    String secondLetter = words[1].substring(0, 1).toUpperCase();
    return firstLetter + secondLetter;
  }

  // Return an empty string if the input is empty or does not have valid words
  return '';
}

List<Color> predefinedColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
];

Color getRandomColor() {
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
