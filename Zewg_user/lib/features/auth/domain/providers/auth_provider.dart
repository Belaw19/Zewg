import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg/features/auth/data/repositories/auth_repository.dart';
import 'package:zewg/features/auth/domain/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(AuthLocalDataSource(), AuthRemoteDataSource());
});

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isAuthenticated => user != null;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    final user = await _repo.getSessionUser();
    state = AuthState(user: user);
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

  Future<bool> signUp(String name, String email, String password) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await _repo.signUp(name, email, password);
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

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
