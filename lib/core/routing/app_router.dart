import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/opportunities/presentation/screens/opportunity_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/curator/presentation/screens/curator_dashboard_screen.dart';
import '../../features/curator/presentation/screens/add_opportunity_screen.dart';
import '../../features/curator/presentation/screens/edit_opportunity_screen.dart';
import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding,
    routes: [
      // Onboarding
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Auth Routes
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      
      // Student Routes
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/opportunity/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return OpportunityDetailScreen(opportunityId: id);
        },
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      
      // Curator Routes
      GoRoute(
        path: RouteNames.curatorDashboard,
        builder: (context, state) => const CuratorDashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.addOpportunity,
        builder: (context, state) => const AddOpportunityScreen(),
      ),
      GoRoute(
        path: '/curator/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return EditOpportunityScreen(opportunityId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
