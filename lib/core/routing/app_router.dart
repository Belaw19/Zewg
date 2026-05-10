import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
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
import 'package:zewg/features/profile/presentation/screens/applied_page.dart';
import 'package:zewg/features/profile/presentation/screens/journey_page.dart';
import 'package:zewg/features/profile/presentation/screens/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.welcome,
  routes: [
    GoRoute(path: RoutePaths.welcome, builder: (context, state) => const WelcomePage()),
    GoRoute(path: RoutePaths.onboardingFuture, builder: (context, state) => const OnboardingPage()),
    GoRoute(path: RoutePaths.onboardingScholarship, builder: (context, state) => const ScholarshipOnboardingPage()),
    GoRoute(path: RoutePaths.onboardingManage, builder: (context, state) => const ManageOpportunitiesPage()),
    GoRoute(path: RoutePaths.signIn, builder: (context, state) => const SignInPage()),
    GoRoute(path: RoutePaths.createAccount, builder: (context, state) => CreateAccountPage()),
    GoRoute(path: RoutePaths.homeAll, builder: (context, state) => const ZewgHomePage()),
    GoRoute(path: RoutePaths.jobs, builder: (context, state) => const ZewgJobsPage()),
    GoRoute(path: RoutePaths.internships, builder: (context, state) => const ZewgInternshipsPage()),
    GoRoute(path: RoutePaths.scholarships, builder: (context, state) => const ZewgScholarshipsPage()),
    GoRoute(path: '/opportunities/:id', builder: (context, state) => const OpportunityDetails()),
    GoRoute(path: RoutePaths.journey, builder: (context, state) => const JourneyPage()),
    GoRoute(path: RoutePaths.applied, builder: (context, state) => const AppliedPage()),
    GoRoute(path: RoutePaths.profile, builder: (context, state) => const ProfilePage()),
  
  ],
);
