import 'package:zewg_admin/core/constants/api_constants.dart';
import 'package:zewg_admin/core/network/api_client.dart';
import 'package:zewg_admin/features/auth/domain/models/user_model.dart';

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
}
