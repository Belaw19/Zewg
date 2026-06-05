import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:zewg_admin/main.dart';

import 'helpers/database_test_helper.dart';
import 'helpers/fake_auth_repository.dart';

void main() {
  setUpAll(setUpTestDatabase);

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
        child: const ZewgApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
