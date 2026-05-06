/// User entity representing an authenticated user in the domain layer.
///
/// This entity follows clean architecture principles and contains
/// only business logic without any framework-specific dependencies.
class User {
  /// Unique identifier for the user
  final String id;

  /// User's email address
  final String email;

  /// User's display name
  final String name;

  /// User's role in the system (student, curator, admin)
  final String role;

  /// Authentication token for API requests
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.token,
  });

  /// Creates a copy of this User with the given fields replaced with new values
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.role == role &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        role.hashCode ^
        token.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, role: $role)';
  }
}
