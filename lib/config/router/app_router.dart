import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:auth_test/features/auth/presentation/pages/login_page.dart';
import 'package:auth_test/features/auth/presentation/pages/home_page.dart';

/// GoRouter configuration with auth redirect logic
class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final isAuthenticated = authBloc.state is AuthAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      // If user is not authenticated and not on login page, redirect to login
      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      // If user is authenticated and on login page, redirect to home
      if (isAuthenticated && isLoggingIn) {
        return '/home';
      }

      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Страница не найдена: ${state.matchedLocation}'),
      ),
    ),
  );
}

/// Custom class to make BLoC stream work with GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
