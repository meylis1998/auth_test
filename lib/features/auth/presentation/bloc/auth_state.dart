import 'package:equatable/equatable.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthValidating extends AuthState {
  final String? emailError;
  final String? passwordError;
  final bool isValid;

  const AuthValidating({
    this.emailError,
    this.passwordError,
    this.isValid = false,
  });

  @override
  List<Object?> get props => [emailError, passwordError, isValid];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}
