import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/opportunities/domain/opportunity.dart';
import '../../features/opportunities/presentation/screens/add_opportunity_screen.dart';
import '../../features/opportunities/presentation/screens/dashboard_screen.dart';
import '../../features/opportunities/presentation/screens/edit_opportunity_screen.dart';

class _RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  _RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }

  String? redirect(GoRouterState state) {
    final auth = _ref.read(authProvider);
    if (auth.isLoading) return null;
    final onLogin = state.matchedLocation == '/';
    if (!auth.isAuthenticated && !onLogin) return '/';
    if (auth.isAuthenticated && onLogin) return '/dashboard';
    return null;
  }
}

final _routerNotifierProvider = Provider<_RouterNotifier>((ref) => _RouterNotifier(ref));

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(_routerNotifierProvider);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (_, state) => notifier.redirect(state),
    routes: [
      GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/add-opportunity', builder: (_, __) => const AddOpportunityScreen()),
      GoRoute(
        path: '/edit-opportunity',
        builder: (_, state) {
          final opportunity = state.extra as Opportunity;
          return EditOpportunityScreen(opportunity: opportunity);
        },
      ),
    ],
  );
});
