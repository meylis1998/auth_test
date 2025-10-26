import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_test/config/router/app_router.dart';
import 'package:auth_test/config/theme/app_theme.dart';
import 'package:auth_test/core/di/injection_container.dart' as di;
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = di.sl<AuthBloc>();

    final appRouter = AppRouter(authBloc);

    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        title: 'Auth App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter.router,
      ),
    );
  }
}
