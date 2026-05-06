/// Route name constants for navigation
class RouteNames {
  RouteNames._();

  // Auth routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';

  // Student routes
  static const String home = '/home';
  static const String opportunityDetail = '/opportunity/:id';
  static const String profile = '/profile';
  static const String savedOpportunities = '/saved';
  static const String applicationHistory = '/applications';

  // Curator routes
  static const String curatorDashboard = '/curator';
  static const String addOpportunity = '/curator/add';
  static const String editOpportunity = '/curator/edit/:id';
}
