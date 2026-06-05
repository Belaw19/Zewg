import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg/features/auth/domain/providers/auth_provider.dart';
import 'package:zewg/features/auth/presentation/screens/sign_in_page.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  testWidgets('SignInPage shows branding and sign-in form', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(user: sampleUser),
          ),
        ],
        child: const MaterialApp(home: SignInPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Zewg'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('EMAIL ADDRESS'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
  });

  testWidgets('SignInPage submits credentials without backend error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(user: sampleUser),
          ),
        ],
        child: const MaterialApp(home: SignInPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'test@zewg.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.textContaining('Exception'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
