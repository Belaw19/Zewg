import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

class AuthLocalDataSource {
  static const _keyUser = 'current_user';

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyUser);
    if (raw == null) return null;
    return UserModel.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toMap()));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
