import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

/// Simulates a remote auth API.
/// In production replace with real HTTP calls.
class AuthRemoteDataSource {
  // Seeded mock users (password stored as sha256 hex)
  static final List<Map<String, String>> _mockUsers = [
    {
      'id': 'u1',
      'name': 'Alex Morgan',
      'email': 'alex@zewg.com',
      'role': 'student',
      'passwordHash': _hash('password123'),
    },
    {
      'id': 'u2',
      'name': 'Curator One',
      'email': 'curator@zewg.com',
      'role': 'curator',
      'passwordHash': _hash('curator123'),
    },
  ];

  static String _hash(String input) =>
      sha256.convert(utf8.encode(input)).toString();

  Future<UserModel> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulate latency
    final hash = _hash(password);
    final match = _mockUsers.where(
      (u) => u['email'] == email.trim().toLowerCase() && u['passwordHash'] == hash,
    );
    if (match.isEmpty) throw Exception('Invalid email or password.');
    final u = match.first;
    return UserModel(id: u['id']!, name: u['name']!, email: u['email']!, role: u['role']!);
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final exists = _mockUsers.any((u) => u['email'] == email.trim().toLowerCase());
    if (exists) throw Exception('An account with this email already exists.');
    final newUser = {
      'id': 'u${_mockUsers.length + 1}',
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'role': 'student',
      'passwordHash': _hash(password),
    };
    _mockUsers.add(newUser);
    return UserModel(
      id: newUser['id']!,
      name: newUser['name']!,
      email: newUser['email']!,
      role: newUser['role']!,
    );
  }
}
