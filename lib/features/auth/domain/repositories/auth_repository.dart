import 'package:dartz/dartz.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User?>> getStoredUser();
}
