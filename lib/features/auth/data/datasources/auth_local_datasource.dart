import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/core/datasources/secure_storage_datasource.dart';
import 'package:auth_test/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel?> getStoredUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageDataSource secureStorage;

  static const _validEmail = 'test@test.com';
  static const _validPassword = 'qwerty123';

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    
    await Future.delayed(const Duration(milliseconds: 1500));

    if (email == _validEmail && password == _validPassword) {
      
      final user = UserModel(email: email);

      await secureStorage.saveUser(email);

      return user;
    } else {
      
      throw const AuthFailure('Неверный логин или пароль');
    }
  }

  @override
  Future<void> logout() async {
    
    await secureStorage.deleteUser();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<UserModel?> getStoredUser() async {
    try {
      final email = await secureStorage.getUser();
      if (email != null && email.isNotEmpty) {
        return UserModel(email: email);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
