import 'package:equatable/equatable.dart';

/// Base class for all failures in the app
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure when validation fails (email/password format)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure during authentication (invalid credentials, network, etc.)
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Failure when server returns an error
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
