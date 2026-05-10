import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/opportunities/presentation/screens/dashboard_screen.dart';
import '../../features/opportunities/presentation/screens/add_opportunity_screen.dart';
import '../../features/opportunities/presentation/screens/edit_opportunity_screen.dart';
import '../../features/opportunities/domain/opportunity.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/add-opportunity',
        builder: (context, state) => const AddOpportunityScreen(),
      ),
      GoRoute(
        path: '/edit-opportunity',
        builder: (context, state) {
          final opportunity = state.extra as Opportunity;

          return EditOpportunityScreen(
            opportunity: opportunity,
          );
        },
      ),
    ],
  );
}
