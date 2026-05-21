import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/features/auth/domain/providers/auth_provider.dart';
import 'package:zewg/features/auth/presentation/screens/create_account_page.dart';
import 'package:zewg/features/auth/presentation/screens/manage_opportunities_page.dart';
import 'package:zewg/features/auth/presentation/screens/onboarding_page.dart';
import 'package:zewg/features/auth/presentation/screens/scholarship_onboarding_page.dart';
import 'package:zewg/features/auth/presentation/screens/sign_in_page.dart';
import 'package:zewg/features/auth/presentation/screens/welcome_page.dart';
import 'package:zewg/features/home/presentation/screens/opportunity_details_page.dart';
import 'package:zewg/features/home/presentation/screens/zewg_home_page.dart';
import 'package:zewg/features/home/presentation/screens/zewg_internships_page.dart';
import 'package:zewg/features/home/presentation/screens/zewg_jobs_page.dart';
import 'package:zewg/features/home/presentation/screens/zewg_scholarships_page.dart';
import 'package:zewg/features/profile/presentation/screens/journey_page.dart';
import 'package:zewg/features/profile/presentation/screens/profile_page.dart';

const _publicRoutes = {
  RoutePaths.welcome,
  RoutePaths.onboardingFuture,
  RoutePaths.onboardingScholarship,
  RoutePaths.onboardingManage,
  RoutePaths.signIn,
  RoutePaths.createAccount,
};

/// Bridges Riverpod auth state → GoRouter refreshListenable.
class _RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  _RouterNotifier(this._ref) {
    // Listen to auth changes and notify GoRouter to re-run redirect
    _ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }

  String? redirect(GoRouterState state) {
    final auth = _ref.read(authProvider);
    if (auth.isLoading) return null;
    final isPublic = _publicRoutes.contains(state.matchedLocation);
    if (!auth.isAuthenticated && !isPublic) return RoutePaths.signIn;
    if (auth.isAuthenticated && isPublic) return RoutePaths.homeAll;
    return null;
  }
}

final _routerNotifierProvider = Provider<_RouterNotifier>((ref) {
  return _RouterNotifier(ref);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(_routerNotifierProvider);
  return GoRouter(
    initialLocation: RoutePaths.welcome,
    refreshListenable: notifier,
    redirect: (_, state) => notifier.redirect(state),
    routes: [
      GoRoute(path: RoutePaths.welcome, builder: (_, __) => const WelcomePage()),
      GoRoute(path: RoutePaths.onboardingFuture, builder: (_, __) => const OnboardingPage()),
      GoRoute(path: RoutePaths.onboardingScholarship, builder: (_, __) => const ScholarshipOnboardingPage()),
      GoRoute(path: RoutePaths.onboardingManage, builder: (_, __) => const ManageOpportunitiesPage()),
      GoRoute(path: RoutePaths.signIn, builder: (_, __) => const SignInPage()),
      GoRoute(path: RoutePaths.createAccount, builder: (_, __) => const CreateAccountPage()),
      GoRoute(path: RoutePaths.homeAll, builder: (_, __) => const ZewgHomePage()),
      GoRoute(path: RoutePaths.jobs, builder: (_, __) => const ZewgJobsPage()),
      GoRoute(path: RoutePaths.internships, builder: (_, __) => const ZewgInternshipsPage()),
      GoRoute(path: RoutePaths.scholarships, builder: (_, __) => const ZewgScholarshipsPage()),
      GoRoute(
        path: '/opportunities/:id',
        builder: (_, state) => OpportunityDetails(id: state.pathParameters['id']!),
      ),
      GoRoute(path: RoutePaths.journey, builder: (_, __) => const JourneyPage()),
      GoRoute(path: RoutePaths.applied, builder: (_, __) => const AppliedPage()),
      GoRoute(path: RoutePaths.profile, builder: (_, __) => const ProfilePage()),
    ],
  );
});
