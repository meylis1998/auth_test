// Basic widget test for auth app
import 'package:flutter_test/flutter_test.dart';
import 'package:auth_test/core/di/injection_container.dart' as di;
import 'package:auth_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_test/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initialize DI
    await di.init();

    // Get the authBloc from DI with type specified
    final authBloc = di.sl<AuthBloc>();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(authBloc: authBloc));

    // Verify that login page is shown (find "Вход" text)
    expect(find.text('Вход'), findsOneWidget);
  });
}
