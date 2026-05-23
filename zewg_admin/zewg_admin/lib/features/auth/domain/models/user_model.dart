class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
  });

  bool get isCurator => role == 'curator';

  factory UserModel.fromApi(Map<String, dynamic> user, {String? token}) => UserModel(
        id: user['id'] as String,
        name: user['name'] as String,
        email: user['email'] as String,
        role: user['role'] as String,
        token: token,
      );
}
