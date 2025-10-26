import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/features/auth/data/models/user_model.dart';

/// Abstract interface for local authentication data source
abstract class AuthLocalDataSource {
  /// Mock login with hardcoded credentials
  /// Simulates network delay of 1.5 seconds
  /// Valid credentials: test@test.com / qwerty123
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// Mock logout
  Future<void> logout();
}

/// Implementation of AuthLocalDataSource
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Hardcoded valid credentials
  static const _validEmail = 'test@test.com';
  static const _validPassword = 'qwerty123';

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay (1.5 seconds as per requirements)
    await Future.delayed(const Duration(milliseconds: 1500));

    // Check credentials
    if (email == _validEmail && password == _validPassword) {
      // Successful login
      return UserModel(email: email);
    } else {
      // Invalid credentials
      throw const AuthFailure('Неверный логин или пароль');
    }
  }

  @override
  Future<void> logout() async {
    // In a real app, this would clear tokens, etc.
    // For now, just complete successfully
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
