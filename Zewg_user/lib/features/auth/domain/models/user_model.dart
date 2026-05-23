class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'student' | 'curator'
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
  });

  bool get isCurator => role == 'curator';

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        role: map['role'] as String,
        token: map['token'] as String?,
      );

  factory UserModel.fromApi(Map<String, dynamic> user, {String? token}) => UserModel(
        id: user['id'] as String,
        name: user['name'] as String,
        email: user['email'] as String,
        role: user['role'] as String,
        token: token,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        if (token != null) 'token': token,
      };

  UserModel copyWith({String? token}) => UserModel(
        id: id,
        name: name,
        email: email,
        role: role,
        token: token ?? this.token,
      );
}
