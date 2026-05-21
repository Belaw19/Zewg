import 'package:zewg/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

class AuthRepository {
  final AuthLocalDataSource _local;
  final AuthRemoteDataSource _remote;

  AuthRepository(this._local, this._remote);

  /// Returns cached user if session exists, otherwise null.
  Future<UserModel?> getSessionUser() => _local.getUser();

  Future<UserModel> signIn(String email, String password) async {
    final user = await _remote.signIn(email, password);
    await _local.saveUser(user);
    return user;
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    final user = await _remote.signUp(name, email, password);
    await _local.saveUser(user);
    return user;
  }

  Future<void> signOut() => _local.clearUser();
}
