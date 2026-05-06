import '../../domain/entities/user.dart';

/// User model for data layer serialization/deserialization.
///
/// Extends the domain User entity and adds JSON conversion capabilities
/// for API communication and local storage.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    required super.token,
  });

  /// Creates a UserModel from a User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      role: user.role,
      token: user.token,
    );
  }

  /// Creates a UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
    );
  }

  /// Converts this UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'token': token,
    };
  }

  /// Creates a copy of this UserModel with the given fields replaced
  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
