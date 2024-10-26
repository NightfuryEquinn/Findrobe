import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthDataNotifier extends StateNotifier<AuthDataState> {
  final AuthRepo _authRepo;

  AuthDataNotifier(this._authRepo) : super(AuthDataState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = _authRepo.getCurrentUser();
    
    final isAdmin = await _authRepo.checkAdminStatus(user!.uid);
    final isRestricted = await _authRepo.checkRestricted(user.uid);

    state = state.copyWith(user: user, isAdmin: isAdmin, isRestricted: isRestricted);
  }

  Future<void> clearSession() async {
    state = AuthDataState.initial();
  }

  Future<User?> signInUser(String email, String password) async {
    try {
      final user = await _authRepo.signInWithEmailPassword(email, password);
      final isAdmin = await _authRepo.checkAdminStatus(user!.uid);
      final isRestricted = await _authRepo.checkRestricted(user.uid);

      state = state.copyWith(user: user, isAdmin: isAdmin, isRestricted: isRestricted);

      if (isRestricted) {
        return null;
      }
      
      return user;
    } catch (e) {
      print("Error signing in user: $e");
      return null;
    }
  }
}

final authDataProvider = Provider<AuthRepo>((ref) {
  return AuthRepo();
});

final authDataNotifierProvider = StateNotifierProvider<AuthDataNotifier, AuthDataState>((ref) {
  final authRepo = ref.watch(authDataProvider);
  return AuthDataNotifier(authRepo);
});