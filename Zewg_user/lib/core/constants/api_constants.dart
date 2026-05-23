/// Base URL for the local Zewg API.
///
/// Override at run time:
/// `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000`
class ApiConstants {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const opportunities = '/opportunities';
}
