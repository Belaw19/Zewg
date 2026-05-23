import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

class AuthRepository {
  final AuthLocalDataSource _local;
  final AuthRemoteDataSource _remote;
  final ApiClient _client;

  AuthRepository(this._local, this._remote, this._client);

  Future<UserModel?> getSessionUser() async {
    final user = await _local.getUser();
    if (user?.token != null) _client.setToken(user!.token);
    return user;
  }

  Future<UserModel> signIn(String email, String password) async {
    final user = await _remote.signIn(email, password);
    await _local.saveUser(user);
    return user;
  }

  Future<UserModel> signUp(String name, String email, String password, {String role = 'student'}) async {
    final user = await _remote.signUp(name, email, password, role: role);
    await _local.saveUser(user);
    return user;
  }

  Future<void> signOut() async {
    _client.setToken(null);
    await _local.clearUser();
  }
}
