import 'package:dartz/dartz.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await dataSource.login(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on AuthFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(AuthFailure('Произошла непредвиденная ошибка: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await dataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure('Ошибка при выходе: $e'));
    }
  }

  @override
  Future<Either<Failure, User?>> getStoredUser() async {
    try {
      final userModel = await dataSource.getStoredUser();
      if (userModel != null) {
        return Right(userModel.toEntity());
      }
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure('Ошибка восстановления сессии: $e'));
    }
  }
}
