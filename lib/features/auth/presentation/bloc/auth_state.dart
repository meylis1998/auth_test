import 'package:equatable/equatable.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

/// Base class for all AuthBloc states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when app starts
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when validating input fields (real-time validation)
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

/// State when login is in progress (showing loading indicator)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when user is successfully authenticated
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// State when authentication fails
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

/// State when user is logged out
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}
