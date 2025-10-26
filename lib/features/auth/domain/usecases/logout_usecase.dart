import 'package:dartz/dartz.dart';
import 'package:auth_test/core/error/failures.dart';
import 'package:auth_test/core/usecases/usecase.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
