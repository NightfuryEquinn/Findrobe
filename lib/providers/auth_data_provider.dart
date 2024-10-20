import 'package:findrobe_app/firebase/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthDataNotifier extends StateNotifier<User?> {
  final AuthRepo _authRepo;

  AuthDataNotifier(this._authRepo) : super(null) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final user = _authRepo.getCurrentUser();
    state = user;
  }

  Future<User?> signInUser(String email, String password) async {
    try {
      final user = await _authRepo.signInWithEmailPassword(email, password);
      state = user;

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

final authDataNotifierProvider = StateNotifierProvider<AuthDataNotifier, User?>((ref) {
  final authRepo = ref.watch(authDataProvider);
  return AuthDataNotifier(authRepo);
});