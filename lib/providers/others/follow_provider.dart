import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findrobe_app/constants/firebase_collection.dart';
import 'package:findrobe_app/constants/states.dart';
import 'package:findrobe_app/providers/auth_data_provider.dart';
import 'package:findrobe_app/providers/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowNotifier extends StateNotifier<FollowState> {
  final String currentUserId;
  final String followUserId;

  FollowNotifier({
    required this.currentUserId,
    required this.followUserId,
    required int followersCount,
    required bool isFollowing
  }) : super(
    FollowState(
      followersCount: followersCount, 
      isFollowing: isFollowing
    )
  ) {
    _checkIfFollowed();
  }

  Future<void> _checkIfFollowed() async {
    try {
      DocumentSnapshot followDoc = await usersCollection
      .doc(followUserId)
      .collection(followersInUserCollection)
      .doc(currentUserId)
      .get();

      if (followDoc.exists) {
        state = state.copyWith(isFollowing: true);
      } else {
        state = state.copyWith(isFollowing: false);
      }
    } catch (e) {
      print("Failed to check following status: $e");
    }
  }

  Future<void> followUser(WidgetRef ref) async {
    await ref.read(userDataNotifierProvider.notifier).followUser(currentUserId, followUserId);

    state = state.copyWith(
      isFollowing: true,
      followersCount: state.followersCount + 1
    );
  }

  Future<void> unfollowUser(WidgetRef ref) async {
    await ref.read(userDataNotifierProvider.notifier).unfollowUser(currentUserId, followUserId);

    state = state.copyWith(
      isFollowing: false,
      followersCount: state.followersCount - 1
    );
  }
}

final followNotifierProvider = StateNotifierProvider.family<FollowNotifier, FollowState, String>((ref, followUserId) {
  final currentUserId = ref.watch(authDataNotifierProvider)?.uid;

  return FollowNotifier(
    currentUserId: currentUserId!, 
    followUserId: followUserId, 
    followersCount: 0, 
    isFollowing: false
  );
});