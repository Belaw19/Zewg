import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg/features/auth/data/repositories/auth_repository.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRepository(
    AuthLocalDataSource(),
    AuthRemoteDataSource(client),
    client,
  );
});

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isAuthenticated => user != null;
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _restoreSession();
    return const AuthState(isLoading: true);
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _restoreSession() async {
    try {
      final user = await _repo.getSessionUser();
      state = AuthState(user: user);
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<bool> signIn(String email, String password) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await _repo.signIn(email, password);
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = AuthState(error: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password, {String role = 'student'}) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await _repo.signUp(name, email, password, role: role);
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = AuthState(error: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
