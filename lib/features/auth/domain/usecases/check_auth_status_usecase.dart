import 'package:dartz/dartz.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/core/usecases/usecase.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getStoredUser();
  }
}
