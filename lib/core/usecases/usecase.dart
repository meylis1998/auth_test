import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:auth_test/core/error/failures.dart';

/// Base interface for all use cases
/// [T] - Return type of the use case
/// [Params] - Input parameters for the use case
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Class to use when no parameters are needed
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
