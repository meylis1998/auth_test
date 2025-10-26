import 'package:equatable/equatable.dart';

/// Base class for all AuthBloc events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when user types in email field
class EmailChanged extends AuthEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// Event triggered when user types in password field
class PasswordChanged extends AuthEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

/// Event triggered when login button is pressed
class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

/// Event triggered when logout button is pressed
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
