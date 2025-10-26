import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:auth_test/features/auth/presentation/pages/splash_page.dart';
import 'package:auth_test/features/auth/presentation/pages/login_page.dart';
import 'package:auth_test/features/auth/presentation/pages/home_page.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isUnauthenticated = authState is AuthUnauthenticated;
      final isInitial = authState is AuthInitial;
      final currentLocation = state.matchedLocation;

      if (isInitial) {
        if (currentLocation != '/splash') {
          return '/splash';
        }
        return null;
      }

      if (isAuthenticated) {
        
        if (currentLocation == '/login' || currentLocation == '/splash') {
          return '/home';
        }
        return null;
      }

      if (isUnauthenticated) {
        
        if (currentLocation == '/home' || currentLocation == '/splash') {
          return '/login';
        }
        return null;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),
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
