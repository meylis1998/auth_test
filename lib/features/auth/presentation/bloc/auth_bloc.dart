import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_test/core/usecases/usecase.dart';
import 'package:auth_test/core/utils/validators.dart';
import 'package:auth_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/logout_usecase.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_state.dart';

/// BLoC for handling authentication logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
    : super(const AuthInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  // Current input values
  String _currentEmail = '';
  String _currentPassword = '';

  /// Handle email field changes with real-time validation
  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    _currentEmail = event.email;
    final emailError = Validators.validateEmail(_currentEmail);
    final passwordError = Validators.validatePassword(_currentPassword);

    emit(
      AuthValidating(
        emailError: emailError,
        passwordError: passwordError,
        isValid: emailError == null && passwordError == null,
      ),
    );
  }

  /// Handle password field changes with real-time validation
  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    _currentPassword = event.password;
    final emailError = Validators.validateEmail(_currentEmail);
    final passwordError = Validators.validatePassword(_currentPassword);

    emit(
      AuthValidating(
        emailError: emailError,
        passwordError: passwordError,
        isValid: emailError == null && passwordError == null,
      ),
    );
  }

  /// Handle login submission
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    // Validate inputs before submitting
    final emailError = Validators.validateEmail(event.email);
    final passwordError = Validators.validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      emit(
        AuthValidating(
          emailError: emailError,
          passwordError: passwordError,
          isValid: false,
        ),
      );
      return;
    }

    // Show loading state
    emit(const AuthLoading());

    // Call login use case
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    // Handle result
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Handle logout
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await logoutUseCase(NoParams());

    result.fold((failure) => emit(AuthError(failure.message)), (_) {
      _currentEmail = '';
      _currentPassword = '';
      emit(const AuthUnauthenticated());
    });
  }
}
