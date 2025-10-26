
class Validators {
  
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email не может быть пустым';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Введите корректный email';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Пароль не может быть пустым';
    }

    if (password.length < 6) {
      return 'Пароль должен содержать минимум 6 символов';
    }

    return null;
  }

  static bool validateCredentials(String email, String password) {
    return validateEmail(email) == null && validatePassword(password) == null;
  }
}
