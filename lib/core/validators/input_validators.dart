

bool containsUppercase(String input) {
  return RegExp(r'[A-Z]').hasMatch(input);
}

bool containsLowercase(String input) {
  return RegExp(r'[a-z]').hasMatch(input);
}

bool containsNumber(String input) {
  return RegExp(r'\d').hasMatch(input);
}
