String? validatePositiveNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }

  try {
    final number = double.parse(value);
    if (number <= 0) {
      return 'Please enter a positive number';
    }
  } catch (e) {
    return 'Please enter a valid number';
  }

  return null;
}
