import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends AuthEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();
}
