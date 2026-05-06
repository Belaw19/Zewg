import '../entities/user.dart';

/// Authentication repository interface defining the contract for authentication operations.
///
/// This interface follows clean architecture principles by defining the contract
/// in the domain layer, with implementations in the data layer.
abstract class AuthRepository {
  /// Authenticates a user with email and password credentials.
  ///
  /// Returns a [User] entity on successful authentication.
  /// Throws an exception if authentication fails.
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password
  Future<User> login({
    required String email,
    required String password,
  });

  /// Creates a new user account with the provided information.
  ///
  /// Returns a [User] entity on successful signup.
  /// Throws an exception if signup fails (e.g., email already exists).
  ///
  /// Parameters:
  /// - [email]: The user's email address
  /// - [password]: The user's password
  /// - [name]: The user's display name
  /// - [role]: The user's role (student, curator, admin)
  Future<User> signup({
    required String email,
    required String password,
    required String name,
    required String role,
  });

  /// Logs out the current user by clearing authentication data.
  ///
  /// This includes clearing the authentication token and any cached user data.
  Future<void> logout();

  /// Retrieves the currently authenticated user.
  ///
  /// Returns a [User] entity if a user is authenticated.
  /// Returns null if no user is currently authenticated.
  Future<User?> getCurrentUser();
}
