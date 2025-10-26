import 'package:dartz/dartz.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  /// Returns Either with Failure or User
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Logout the current user
  /// Returns Either with Failure or void
  Future<Either<Failure, void>> logout();
}
