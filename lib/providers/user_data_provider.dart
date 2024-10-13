import 'package:findrobe_app/firebase/user_repo.dart';
import 'package:findrobe_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataNotifier extends StateNotifier<FindrobeUser?> {
  final UserRepo _userRepo;

  UserDataNotifier(this._userRepo) : super(null) {
    fetchUserData();
  }

  // Getter
  FindrobeUser? get findrobeUser => state;

  Future<void> fetchUserData() async {
    try {
      final user = await _userRepo.fetchUserData();
      state = user;
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> logoutUser() async {
    try {
      await _userRepo.logoutUser();
      state = null;
    } catch (e) {
      print("Error log out: $e");
    }
  }
}

final userDataProvider = Provider<UserRepo>((ref) {
  return UserRepo();
});

final userDataNotifierProvider = StateNotifierProvider<UserDataNotifier, FindrobeUser?>((ref) {
  final userRepo = ref.watch(userDataProvider);
  return UserDataNotifier(userRepo);
});