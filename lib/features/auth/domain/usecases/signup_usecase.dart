import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user signup/registration.
///
/// Encapsulates the business logic for creating a new user account.
/// Follows clean architecture principles by separating business logic
/// from presentation and data layers.
class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  /// Executes the signup use case.
  ///
  /// Validates user input and creates a new account through the repository.
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password
  /// - [name]: The user's display name
  /// - [role]: The user's role (student, curator, admin)
  ///
  /// Returns a [User] entity on successful signup.
  /// Throws an exception if signup fails.
  Future<User> execute({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    // Validate email format
    if (email.isEmpty || !_isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    // Validate password strength
    if (!_isValidPassword(password)) {
      throw Exception(
        'Password must be at least 8 characters long and contain '
        'at least one uppercase letter, one lowercase letter, and one number',
      );
    }

    // Validate name
    if (name.isEmpty || name.trim().length < 2) {
      throw Exception('Name must be at least 2 characters long');
    }

    // Validate role
    if (role.isEmpty) {
      throw Exception('Role must be specified');
    }

    // Delegate to repository for account creation
    return await _repository.signup(
      email: email,
      password: password,
      name: name.trim(),
      role: role,
    );
  }

  /// Validates email format using a simple regex pattern
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates password strength
  /// Requires at least 8 characters, one uppercase, one lowercase, and one number
  bool _isValidPassword(String password) {
    if (password.length < 8) return false;

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));

    return hasUppercase && hasLowercase && hasDigit;
  }
}
