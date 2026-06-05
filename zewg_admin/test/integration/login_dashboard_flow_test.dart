import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:zewg_admin/core/theme/app_theme.dart';
import 'package:zewg_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:zewg_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:zewg_admin/features/opportunities/presentation/providers/opportunity_provider.dart';
import 'package:zewg_admin/features/opportunities/presentation/screens/dashboard_screen.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_opportunity_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  testWidgets('admin login then view opportunities on dashboard', (tester) async {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          FakeAuthRepository(user: sampleCurator),
        ),
        opportunityRepositoryProvider.overrideWithValue(
          FakeOpportunityRepository(testOpportunities),
        ),
      ],
    );
    addTearDown(container.dispose);

    final authRefresh = _AuthRefreshListenable(container);
    addTearDown(authRefresh.dispose);

    final router = GoRouter(
      initialLocation: '/',
      refreshListenable: authRefresh,
      redirect: (_, state) {
        final auth = container.read(authProvider);
        if (auth.isLoading) return null;
        final onLogin = state.matchedLocation == '/';
        if (!auth.isAuthenticated && !onLogin) return '/';
        if (auth.isAuthenticated && onLogin) return '/dashboard';
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: ZewgTheme.theme,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome back Admin'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), sampleCurator.email);
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Managed Opportunities'), findsOneWidget);
    expect(find.text('Welcome back,\nCurator.'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.scrollUntilVisible(
      find.text('Flutter Developer Intern'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Flutter Developer Intern'), findsOneWidget);
  });
}

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(this._container) {
    _container.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }

  final ProviderContainer _container;

  @override
  void dispose() {
    super.dispose();
  }
}
