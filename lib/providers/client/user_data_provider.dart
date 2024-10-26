import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/firebase/user_repo.dart';
import 'package:findrobe_app/providers/client/auth_data_provider.dart';
import 'package:findrobe_app/providers/client/posts_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataNotifier extends StateNotifier<UserDataState> {
  final UserRepo _userRepo;

  UserDataNotifier(this._userRepo) : super(UserDataState.initial()) {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = await _userRepo.fetchUserData();
      state = state.copyWith(currentUser: user);
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> fetchViewUserData(String userId) async {
    try {
      final user = await _userRepo.fetchViewUserData(userId);
      state = state.copyWith(otherUser: user);
    } catch (e) {
      print("Error fetching view user data: $e");
    }
  }

  Future<bool> updateProfile(String username, dynamic profilePic, String email) async {
    try {
      await _userRepo.updateProfile(username, profilePic, email);
      return true;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  Future<void> logoutUser(WidgetRef ref) async {
    try {
      await _userRepo.logoutUser();
      state = UserDataState.initial();

      await ref.read(postsDataNotifierProvider.notifier).clearPosts();
      await ref.read(authDataNotifierProvider.notifier).clearSession();
    } catch (e) {
      print("Error log out: $e");
    }
  }

  Future<bool> followUser(String currentUserId, String followUserId) async {
    try {
      final bool followed = await _userRepo.followUser(currentUserId, followUserId);
      return followed;
    } catch (e) {
      print("Error follow user: $e");
      return false;
    }
  }
  
  Future<bool> unfollowUser(String currentUserId, String followUserId) async {
    try {
      final bool unfollowed = await _userRepo.unfollowUser(currentUserId, followUserId);
      return unfollowed;
    } catch (e) {
      print("Error unfollow user: $e");
      return false;
    }
  }
}

final userDataProvider = Provider<UserRepo>((ref) {
  return UserRepo();
});

final userDataNotifierProvider = StateNotifierProvider<UserDataNotifier, UserDataState>((ref) {
  final userRepo = ref.watch(userDataProvider);
  return UserDataNotifier(userRepo);
});