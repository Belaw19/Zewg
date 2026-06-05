import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_theme.dart';
import 'package:zewg/features/auth/domain/providers/auth_provider.dart';
import 'package:zewg/features/auth/presentation/screens/sign_in_page.dart';
import 'package:zewg/features/home/presentation/screens/zewg_home_page.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

import '../test/helpers/fake_auth_repository.dart';
import '../test/helpers/fake_opportunity_repository.dart';
import '../test/helpers/sample_data.dart';

void main() {
  testWidgets('login then view opportunities on home', (tester) async {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          FakeAuthRepository(user: sampleUser),
        ),
        opportunityRepositoryProvider.overrideWithValue(
          FakeOpportunityRepository(sampleOpportunities),
        ),
      ],
    );
    addTearDown(container.dispose);

    final authRefresh = _AuthRefreshListenable(container);
    addTearDown(authRefresh.dispose);

    final router = GoRouter(
      initialLocation: RoutePaths.signIn,
      refreshListenable: authRefresh,
      redirect: (_, state) {
        final auth = container.read(authProvider);
        if (auth.isLoading) return null;
        if (auth.isAuthenticated && state.matchedLocation == RoutePaths.signIn) {
          return RoutePaths.homeAll;
        }
        if (!auth.isAuthenticated && state.matchedLocation == RoutePaths.homeAll) {
          return RoutePaths.signIn;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: RoutePaths.signIn,
          builder: (_, __) => const SignInPage(),
        ),
        GoRoute(
          path: RoutePaths.homeAll,
          builder: (_, __) => const ZewgHomePage(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: buildAppTheme(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), sampleUser.email);
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Flutter Developer Intern'), findsOneWidget);
    expect(find.text('Featured Opportunities'), findsOneWidget);
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
