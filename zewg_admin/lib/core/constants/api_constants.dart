class ApiConstants {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const opportunities = '/opportunities';
}
