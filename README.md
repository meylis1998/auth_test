# Auth Test

Flutter приложение для аутентификации с Clean Architecture и BLoC.

## Используемые библиотеки

### Основные
- **flutter_bloc** (^9.1.1) - управление состоянием
- **get_it** (^8.2.0) - dependency injection
- **go_router** (^16.3.0) - навигация с защитой маршрутов
- **flutter_secure_storage** (^9.2.2) - безопасное хранение данных
- **dartz** (^0.10.1) - паттерн Either для обработки ошибок
- **freezed** (^2.5.7) - генерация immutable моделей
- **equatable** (^2.0.5) - сравнение состояний в BLoC

## Нестандартные решения

### 1. Secure Storage с платформо-специфичной конфигурацией
Настроена в `lib/core/di/injection_container.dart:40-48`:
- **Android**: `encryptedSharedPreferences: true` (AES-256)
- **iOS**: `KeychainAccessibility.first_unlock`

### 2. Splash Screen с проверкой аутентификации
В `lib/main.dart:14-15` проверка состояния авторизации происходит до рендеринга приложения.

### 3. GoRouter Guard
Автоматическая переадресация на основе состояния аутентификации в `lib/config/router/app_router.dart`.

### 4. Either Pattern для обработки ошибок
Все методы репозиториев возвращают `Either<Failure, T>` для явной обработки ошибок.

## Установка

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Тестовые данные
- Email: `test@example.com`
- Password: `password123`
