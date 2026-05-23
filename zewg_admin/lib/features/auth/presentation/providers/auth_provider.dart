import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg_admin/core/network/api_client.dart';
import 'package:zewg_admin/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:zewg_admin/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:zewg_admin/features/auth/data/repositories/auth_repository.dart';
import 'package:zewg_admin/features/auth/domain/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRepository(AuthLocalDataSource(), AuthRemoteDataSource(client), client);
});

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isAuthenticated => user != null && user!.isCurator;
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _restore();
    return const AuthState(isLoading: true);
  }

  Future<void> _restore() async {
    try {
      final user = await ref.read(authRepositoryProvider).getSessionUser();
      state = AuthState(user: user?.isCurator == true ? user : null);
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<bool> signIn(String email, String password) async {
    state = const AuthState(isLoading: true);
    try {
      final user = await ref.read(authRepositoryProvider).signIn(email, password);
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = AuthState(error: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
