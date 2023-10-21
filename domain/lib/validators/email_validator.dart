class EmailValidator {
  static bool get(String text) {
    // Regular expression pattern for email validation
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$';

    // Create a RegExp object with the pattern
    final regex = RegExp(pattern);

    // Use the RegExp object's hasMatch() method to check if the email matches the pattern
    return regex.hasMatch(text);
  }
}
