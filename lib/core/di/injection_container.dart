import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:auth_test/core/datasources/secure_storage_datasource.dart';
import 'package:auth_test/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:auth_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:auth_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/logout_usecase.dart';
import 'package:auth_test/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthStatusUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );

  sl.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSourceImpl(sl()),
  );

  sl.registerLazySingleton(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    ),
  );
}
