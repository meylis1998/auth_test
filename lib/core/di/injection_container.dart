import 'package:get_it/get_it.dart';
import 'package:auth_test/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/logout_usecase.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  //! Core
  // No core dependencies yet

  //! External
  // No external dependencies yet
}
