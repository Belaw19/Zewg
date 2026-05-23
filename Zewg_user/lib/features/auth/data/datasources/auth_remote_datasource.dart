import 'package:zewg/core/constants/api_constants.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSource(this._client);

  Future<UserModel> signIn(String email, String password) async {
    final data = await _client.safePost(
      ApiConstants.authLogin,
      body: {'email': email.trim(), 'password': password},
    );
    final token = data['token'] as String;
    final user = UserModel.fromApi(data['user'] as Map<String, dynamic>, token: token);
    _client.setToken(token);
    return user;
  }

  Future<UserModel> signUp(String name, String email, String password, {String role = 'student'}) async {
    final data = await _client.safePost(
      ApiConstants.authRegister,
      body: {
        'name': name.trim(),
        'email': email.trim(),
        'password': password,
        'role': role,
      },
    );
    final token = data['token'] as String;
    final user = UserModel.fromApi(data['user'] as Map<String, dynamic>, token: token);
    _client.setToken(token);
    return user;
  }
}
