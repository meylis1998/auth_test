/// Utility class for input validation
class Validators {
  // Email validation regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validates email format
  /// Returns error message if invalid, null if valid
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email не может быть пустым';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Введите корректный email';
    }

    return null;
  }

  /// Validates password length (minimum 6 characters)
  /// Returns error message if invalid, null if valid
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Пароль не может быть пустым';
    }

    if (password.length < 6) {
      return 'Пароль должен содержать минимум 6 символов';
    }

    return null;
  }

  /// Validates both email and password
  /// Returns true if both are valid
  static bool validateCredentials(String email, String password) {
    return validateEmail(email) == null && validatePassword(password) == null;
  }
}
