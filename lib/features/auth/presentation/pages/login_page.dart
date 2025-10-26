import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_event.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:auth_test/features/auth/presentation/widgets/email_input_field.dart';
import 'package:auth_test/features/auth/presentation/widgets/password_input_field.dart';
import 'package:auth_test/features/auth/presentation/widgets/primary_button.dart';

/// Login page with email and password fields
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    context.read<AuthBloc>().add(
      LoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          }
          // Show error snackbar
          else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          String? emailError;
          String? passwordError;

          if (state is AuthValidating) {
            emailError = state.emailError;
            passwordError = state.passwordError;
          }

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // App Logo/Icon
                      Icon(
                        Icons.lock_person_rounded,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        'Вход',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        'Войдите в свой аккаунт',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 40),

                      EmailInputField(
                        controller: _emailController,
                        errorText: emailError,
                        onChanged: (value) {
                          context.read<AuthBloc>().add(EmailChanged(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      PasswordInputField(
                        controller: _passwordController,
                        errorText: passwordError,
                        onChanged: (value) {
                          context.read<AuthBloc>().add(PasswordChanged(value));
                        },
                        onEditingComplete: () => _handleLogin(context),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          text: 'Войти',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () => _handleLogin(context),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
