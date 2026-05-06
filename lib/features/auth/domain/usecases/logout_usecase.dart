import '../repositories/auth_repository.dart';

/// Use case for user logout.
///
/// Encapsulates the business logic for logging out a user and clearing
/// authentication data. Follows clean architecture principles by separating
/// business logic from presentation and data layers.
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  /// Executes the logout use case.
  ///
  /// Clears authentication tokens and cached user data through the repository.
  ///
  /// Returns a Future that completes when logout is successful.
  /// Throws an exception if logout fails.
  Future<void> execute() async {
    await _repository.logout();
  }
}
