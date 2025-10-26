import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/core/usecases/usecase.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';

/// Use case for logging in a user
class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for login use case
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
