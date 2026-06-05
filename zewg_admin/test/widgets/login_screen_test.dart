import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:zewg_admin/features/auth/presentation/screens/login_screen.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  testWidgets('LoginScreen shows admin branding and form', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(user: sampleCurator),
          ),
        ],
        child: MaterialApp(theme: ThemeData(), home: const LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Zewg'), findsOneWidget);
    expect(find.text('Welcome back Admin'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('EMAIL ADDRESS'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
  });

  testWidgets('LoginScreen submits credentials without backend error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(user: sampleCurator),
          ),
        ],
        child: MaterialApp(theme: ThemeData(), home: const LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), sampleCurator.email);
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.textContaining('Exception'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
