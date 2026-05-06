import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user login authentication.
///
/// Encapsulates the business logic for authenticating a user with
/// email and password credentials. Follows clean architecture principles
/// by separating business logic from presentation and data layers.
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Executes the login use case.
  ///
  /// Validates credentials and authenticates the user through the repository.
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password
  ///
  /// Returns a [User] entity on successful authentication.
  /// Throws an exception if authentication fails.
  Future<User> execute({
    required String email,
    required String password,
  }) async {
    // Validate email format
    if (email.isEmpty || !_isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    // Validate password
    if (password.isEmpty) {
      throw Exception('Password cannot be empty');
    }

    // Delegate to repository for authentication
    return await _repository.login(
      email: email,
      password: password,
    );
  }

  /// Validates email format using a simple regex pattern
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
