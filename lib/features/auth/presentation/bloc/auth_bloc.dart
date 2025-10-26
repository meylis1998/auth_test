import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_test/core/usecases/usecase.dart';
import 'package:auth_test/core/utils/validators.dart';
import 'package:auth_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/logout_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthStatusUseCase,
  }) : super(const AuthInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onAuthStatusChecked);
  }

  String _currentEmail = '';
  String _currentPassword = '';

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

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
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

    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

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

  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    
    final startTime = DateTime.now();
    final result = await checkAuthStatusUseCase(NoParams());

    final elapsed = DateTime.now().difference(startTime);
    final remainingTime = const Duration(milliseconds: 1200) - elapsed;

    if (remainingTime.isNegative == false) {
      await Future.delayed(remainingTime);
    }

    result.fold((failure) => emit(const AuthUnauthenticated()), (user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated());
      }
    });
  }
}
