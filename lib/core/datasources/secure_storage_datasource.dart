import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageDataSource {
  
  Future<void> saveUser(String email);

  Future<String?> getUser();

  Future<void> deleteUser();

  Future<bool> hasUser();
}

class SecureStorageDataSourceImpl implements SecureStorageDataSource {
  final FlutterSecureStorage _storage;

  static const _userEmailKey = 'user_email';

  SecureStorageDataSourceImpl(this._storage);

  @override
  Future<void> saveUser(String email) async {
    try {
      await _storage.write(key: _userEmailKey, value: email);
    } catch (e) {
      throw Exception('Ошибка сохранения данных пользователя: $e');
    }
  }

  @override
  Future<String?> getUser() async {
    try {
      return await _storage.read(key: _userEmailKey);
    } catch (e) {
      
      return null;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _storage.delete(key: _userEmailKey);
    } catch (e) {
      throw Exception('Ошибка удаления данных пользователя: $e');
    }
  }

  @override
  Future<bool> hasUser() async {
    try {
      final email = await _storage.read(key: _userEmailKey);
      return email != null && email.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
