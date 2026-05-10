/// Route path strings shared by [GoRouter] and navigation calls.
abstract final class RoutePaths {
  RoutePaths._();

  static const welcome = '/';
  static const onboardingFuture = '/onboarding-future';
  static const onboardingScholarship = '/onboarding-scholarship';
  static const onboardingManage = '/onboarding-manage';
  static const signIn = '/signin';
  static const createAccount = '/create-account';
  static const homeAll = '/all';
  static const jobs = '/jobs';
  static const internships = '/internships';
  static const scholarships = '/scholarships';
  static const journey = '/journey';
  static const applied = '/applied';
  static const profile = '/profile';

  static String opportunity(String id) => '/opportunities/$id';

  // static const adminLogin = '/admin-login';
  // static const adminDashboard = '/admin-dashboard';
  // static const adminAddOpportunity = '/admin-add-opportunity';
  // static const adminEditOpportunity = '/admin-edit-opportunity';
}
