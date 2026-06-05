import 'package:dio/dio.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg/features/auth/data/repositories/auth_repository.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

/// Auth repository that signs in without a backend.
class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository({UserModel? user})
      : _user = user,
        super(
          AuthLocalDataSource(),
          AuthRemoteDataSource(ApiClient(Dio())),
          ApiClient(Dio()),
        );

  final UserModel? _user;

  @override
  Future<UserModel?> getSessionUser() async => null;

  @override
  Future<UserModel> signIn(String email, String password) async {
    if (_user == null) {
      throw Exception('Invalid credentials');
    }
    return _user!;
  }

  @override
  Future<void> signOut() async {}
}
